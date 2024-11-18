## CMakeLists which sets up the custom targets in this project.

# To create a custom target, you first need to figure out the CMake name of the target
# from its Mbed name.  This name is calculated as:
#
# 1. Convert target to lowercase
# 2. Replace all underscores (_) with hyphens (-)
# 3. add "mbed-" prefix.
#
# So, the target named 'L452RE_SIMPLE' will be called mbed-l452re-simple in CMake.
# The Mbed build system will look for a target of this name when configuring, so make sure to create it.

# Another thing to keep in mind is how the Mbed targets are organized for STM32L452.
# At the lowest level, we have mbed-nucleo-l452re-p, which is defined in
# mbed-os/targets/TARGET_STM/TARGET_STM32L4/TARGET_STM32L452xE/TARGET_NUCLEO_L452RE_P/CMakeLists.txt.
# This target is for the dev board specifically, and contains the pinmap files and nothing else.
#
# Up from there, we have mbed-stm32l452xe, which covers any and all boards with the STM32L452 chip.
# This includes the clocking config (system_clock.c), the linker script, and other chip-specific stuff.
# This target is defined in mbed-os/targets/TARGET_STM/TARGET_STM32L4/TARGET_STM32L452xE/CMakeLists.txt.
# By declaring mbed-stm32l452xe as an INTERFACE dependency, mbed-nucleo-l452re-p pulls in all of these aforementioned
# files.
#
# And going up one more level, we have mbed-stm32l4.  This target is for the entire STM32L4 family of chips
# (which are largely compatible from a software perspective).  It includes the actual HAL code used to drive
# the chip.
#
# Note: This is an example for STM32; other vendors can and do set up this hierarchy differently.
# In particular, it's a crapshoot whether the clock config file and the linker script will be
# part of the dev board target or with the MCU target.  Check the manufacturer files to be sure!

# Part 1: L452RE_SIMPLE ---------------------------------------------------------------------

# Creating this target is dead simple, because we want it to be identical to mbed-nucleo-l452re-p
# in all respects.  So, we just need to declare mbed-nucleo-l452re-p as a dependency.
add_library(mbed-l452re-simple INTERFACE)
target_link_libraries(mbed-l452re-simple INTERFACE mbed-nucleo-l452re-p)

# Part 2: L452RE_CUSTOM_PINMAP ---------------------------------------------------------------

# First, we need to create the target and add the source and include files to it.
# This mirrors the logic in TARGET_STM32L452xE/TARGET_NUCLEO_L452RE_P/CMakeLists.txt.
# Note that, for internal CMake reasons, all custom targets must be created as INTERFACE
# targets and have their sources added as INTERFACE sources.
add_library(mbed-l452re-custom-pinmap INTERFACE)
target_sources(mbed-l452re-custom-pinmap INTERFACE L452RE_CUSTOM_PINMAP/PeripheralPins.c)
target_include_directories(mbed-l452re-custom-pinmap INTERFACE L452RE_CUSTOM_PINMAP)

# Now, we can link the mbed-stm32l452xe target, which pulls in all the existing STM32L452RE headers,
# linker scripts, and code.
target_link_libraries(mbed-l452re-custom-pinmap INTERFACE mbed-stm32l452xe)

# Part 2: L452RE_CUSTOM_CLOCK ---------------------------------------------------------------

# In this target, we want to override system_clock.c from Mbed with our own clock config file.
# This file is part of the mbed-stm32l452xe target, so we want to remove it from there
# Mbed has a dedicated function for this, mbed_disable_mcu_target_file().  This function takes
# the target and the filename to remove.
# Note: We only want to call this function when the project is actually configured for the
# L452RE_CUSTOM_CLOCK target.
if("${MBED_TARGET}" STREQUAL "L452RE_CUSTOM_CLOCK")
	mbed_disable_mcu_target_file(mbed-stm32l452xe system_clock.c)
endif()

# Now, we can add our custom target that includes our own clock file.
add_library(mbed-l452re-custom-clock INTERFACE)
target_sources(mbed-l452re-custom-clock INTERFACE L452RE_CUSTOM_CLOCK/system_clock.c)
target_link_libraries(mbed-l452re-custom-clock INTERFACE mbed-nucleo-l452re-p)

# Part 4: L452RC_CUSTOM_MEMORY_MAP --------------------------------------------------------------

# As in part 1, we just create this target as an empty target that inherits from the NUCLEO_L452RE_P target.
add_library(mbed-l452rc-custom-memory-map INTERFACE)
target_link_libraries(mbed-l452rc-custom-memory-map INTERFACE mbed-nucleo-l452re-p)

