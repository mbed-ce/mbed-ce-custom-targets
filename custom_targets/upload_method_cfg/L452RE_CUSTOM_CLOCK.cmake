## Example of custom uploud method for L452RE_CUSTOM_CLOCK


# General config parameters
# -------------------------------------------------------------
set(UPLOAD_METHOD_DEFAULT OPENOCD)

# Config options for OPENOCD
# -------------------------------------------------------------
set(OPENOCD_UPLOAD_ENABLED TRUE)
set(OPENOCD_CHIP_CONFIG_COMMANDS
    -f ${CMAKE_CURRENT_LIST_DIR}/openocd_cfgs/stm32l452re.cfg)