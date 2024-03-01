## Example of custom uploud method for L452RE_CUSTOM_CLOCK


# General config parameters
# -------------------------------------------------------------
set(UPLOAD_METHOD_DEFAULT OPENOCD)

# Config options for OPENOCD
# -------------------------------------------------------------
# We set TRUE to enable OpenOCD
set(OPENOCD_UPLOAD_ENABLED TRUE)
# Here set a path to requested OpenOCD config. In this case we use already implemented one.
set(OPENOCD_CHIP_CONFIG_COMMANDS
    -f ${CMAKE_SOURCE_DIR}/mbed-os/targets/upload_method_cfg/openocd_cfgs/s/stm32l452re.cfg)
