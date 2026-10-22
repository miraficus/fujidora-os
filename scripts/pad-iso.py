#!/usr/bin/env python3
"""Keep the final ISO file readable through BIOS/GRUB read-ahead and hash it."""

import argparse
import hashlib
from pathlib import Path
import struct


PADDING = 300 * 1024
SECTOR = 2048


def volume_end(path):
    with path.open("rb") as stream:
        # ISO 9660 volume descriptors start at logical sector 16.
        for sector in range(16, 80):
            stream.seek(sector * SECTOR)
            descriptor = stream.read(SECTOR)
            if len(descriptor) != SECTOR or descriptor[1:6] != b"CD001":
                break
            if descriptor[0] == 1:
                blocks = struct.unpack_from("<I", descriptor, 80)[0]
                big_blocks = struct.unpack_from(">I", descriptor, 84)[0]
                block_size = struct.unpack_from("<H", descriptor, 128)[0]
                big_block_size = struct.unpack_from(">H", descriptor, 130)[0]
                if blocks != big_blocks or block_size != big_block_size:
                    raise ValueError(f"{path}: inconsistent ISO volume size")
                if not blocks or block_size != SECTOR:
                    raise ValueError(f"{path}: unsupported ISO block size or empty volume")
                return blocks * block_size
            if descriptor[0] == 255:
                break
    raise ValueError(f"{path}: ISO 9660 primary volume descriptor not found")


def pad_iso(path):
    end = volume_end(path)
    size = path.stat().st_size
    if size < end:
        raise ValueError(f"{path}: truncated ISO ({size} bytes; volume needs {end})")
    extra = max(0, end + PADDING - size)
    if extra:
        with path.open("ab") as stream:
            stream.write(bytes(extra))

    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    checksum = Path(str(path) + ".sha256")
    checksum.write_text(f"{digest.hexdigest()}  {path.name}\n", encoding="utf-8")
    print(f"{path}: added {extra} padding bytes; SHA-256 saved to {checksum}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("images", type=Path, nargs="+")
    args = parser.parse_args()
    for path in args.images:
        pad_iso(path)


if __name__ == "__main__":
    main()
