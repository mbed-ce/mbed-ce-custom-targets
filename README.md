## Mbed CE Custom Targets Example

This project shows how to use Mbed OS Community Edition to create custom targets and also defines the standard structure of custom target project from Mbed CE perspective.

This repo includes four different custom targets you can use based on the `NUCLEO_L452RE_P` target.  (No real reason it's this target in particular, it's just a board I happen to use).

1. `L452RE_SIMPLE`, which is simply a clone of `NUCLEO_L452RE_P` with a different name and some extra compile definitions applied.  This would be an example of creating a custom target for your board by simply aliasing one of the built-in Mbed targets.  This target is created only by `custom_targets.json` and `custom_targets/CMakeLists.txt`.  It contains no source files.
2. `L452RE_CUSTOM_PINMAP`, which replaces the pinmap files included with Mbed with custom ones.  This is a common task if you are e.g. using a different chip package and want to have correct pin names (for STM32 there is a [generator](https://github.com/mbed-ce/mbed-os/tree/master/targets/TARGET_STM#board-specific-files-pinmap)).
3. `L452RE_CUSTOM_CLOCK`, which takes it one step further and replaces the system clock configuration code in Mbed with a new source file.  This is a fairly common task if you create a custom board and want to regenerate the clocking code from another source, such as STM32Cube IDE or MCUXpresso.
4. `L452RC_CUSTOM_MEMORY_MAP`, which shows how to adjust the memory layout of Mbed via [memory bank configuration](https://github.com/mbed-ce/mbed-os/wiki/Mbed-Memory-Bank-Information).  In this specific case, we provide memory bank configs in the linker script for the STM32L452RCT variant of the processor, which has half the flash space.  This will be picked up (via the [MBED_ROM_SIZE define](https://github.com/mbed-ce/mbed-os/blob/0a36502cf55bf36112503e72b59e016c5f7993c7/targets/TARGET_STM/TARGET_STM32L4/TARGET_STM32L452xE/TOOLCHAIN_GCC_ARM/stm32l452xe.ld#L26)) in the linker script and used to adjust the memory available to Mbed.
    - Note that not every Mbed target currently has a linker script that is set up for this; you should read through your target's linker script before using this method to adjust the RAM or flash size.

To understand how these targets work, review custom_targets/custom_targets.json5, CMakeLists.txt, and custom_targets/CMakeLists.txt.  These files have been extensively commented with details on how the project is set up.

## How to set up this project:

1. Clone it to your machine.  Don't forget to use `--recursive` to clone the submodules: `git clone --recursive https://github.com/mbed-ce/mbed-ce-custom-targets.git`and update MbedOS with `git submodule update --remote mbed-os` (run this command from the mbed-ce-custom-targets folder)
2. Set up the GNU ARM toolchain (and other programs) on your machine using [the toolchain setup guide](https://github.com/mbed-ce/mbed-os/wiki/Toolchain-Setup-Guide).
3. Set up the CMake project for editing. We have three ways to do this:
    - On the [command line](https://github.com/mbed-ce/mbed-os/wiki/Project-Setup:-Command-Line)
    - Using the [CLion IDE](https://github.com/mbed-ce/mbed-os/wiki/Project-Setup:-CLion)
    - Using the [VS Code IDE](https://github.com/mbed-ce/mbed-os/wiki/Project-Setup:-VS-Code)
4. Use one of the target names listed above and choose an [upload method](https://github.com/mbed-ce/mbed-os/wiki/Upload-Methods) according to your requirements. Default settings is target L452RE_SIMPLE and upload method STM32CUBE.
   
