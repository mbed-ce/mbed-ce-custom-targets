## Mbed CE Custom Targets Example

This project shows how to use Mbed OS Community Edition to create custom targets.  

This repo includes three different custom targets you can use based on the `NUCLEO_L452RE_P` target.  (No real reason it's this target in particular, it's just a board I happen to use).

1. `L452RE_SIMPLE`, which is simply a clone of `NUCLEO_L452RE_P` with a different name and some extra compile definitions applied.  This would be an example of creating a custom target for your board by simply aliasing one of the built-in Mbed targets.  This target is created only by `custom_targets.json` and `custom_targets/CMakeLists.txt`.  It contains no source files.
2. `L452RE_CUSTOM_PINMAP`, which replaces the pinmap files included with Mbed with custom ones.  This is a common task if you are e.g. using a different chip package and want to have correct pin names (for STM32 there is a [generator](https://github.com/mbed-ce/mbed-os/tree/master/targets/TARGET_STM#board-specific-files-pinmap)).
3. `L452RE_CUSTOM_CLOCK`, which takes it one step further and replaces the system clock configuration code in Mbed with a new source file.  This is a fairly common task if you create a custom board and want to regenerate the clocking code from another source, such as STM32Cube IDE or MCUXpresso.

## How to set up this project:

1. Clone it to your machine.  Don't forget to use `--recursive` to clone the submodules: `git clone --recursive https://github.com/mbed-ce/mbed-ce-custom-targets.git`
2. Set up the GNU ARM toolchain (and other programs) on your machine using [the toolchain setup guide](https://github.com/mbed-ce/mbed-os/wiki/Toolchain-Setup-Guide).
3. Set up the CMake project for editing.  Use one of the target names listed above.  We have three ways to do this:
    - On the [command line](https://github.com/mbed-ce/mbed-os/wiki/Project-Setup:-Command-Line)
    - Using the [CLion IDE](https://github.com/mbed-ce/mbed-os/wiki/Project-Setup:-CLion)
    - Using the [VS Code IDE](https://github.com/mbed-ce/mbed-os/wiki/Project-Setup:-VS-Code)
