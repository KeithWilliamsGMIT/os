# Overview

This operating system was developed for learning purposes.

## Requirements

You will need to install the following before getting started:

1. NASM - to compile the assembly into machine code
2. QEMU - to emulate the operating system

## Getting Started

To get started first clone this repository:

```bash
git clone https://github.com/KeithWilliamsGMIT/os.git
```

Then, in a terminal, navigate to the root of the repository and run the following command to compile the boot sector:

```bash
nasm boot-sector.asm -f bin -o boot-sector.bin
```

Once compiled, start the operating system in an emulator:

```bash
qemu-system-x86_64 boot-sector.bin
```
