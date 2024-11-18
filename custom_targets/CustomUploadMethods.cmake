# In this file you can specify the upload method configuration for your custom target(s).
# See here for the list of parameters that can be set:
# https://github.com/mbed-ce/mbed-os/wiki/Upload-Methods

if(MBED_TARGET STREQUAL "L452RE_SIMPLE" OR
	MBED_TARGET STREQUAL "L452RE_CUSTOM_PINMAP" OR
	MBED_TARGET STREQUAL "L452RE_CUSTOM_CLOCK" OR
	MBED_TARGET STREQUAL "L452RC_CUSTOM_MEMORY_MAP")

	# Enable STM32Cube upload method
	set(STM32CUBE_UPLOAD_ENABLED TRUE)
	set(STM32CUBE_CONNECT_COMMAND -c port=SWD reset=HWrst)
	set(STM32CUBE_GDBSERVER_ARGS --swd)

	# Enable Mbed upload method
	set(MBED_UPLOAD_ENABLED TRUE)

	# Default is STM32CUBE
	set(UPLOAD_METHOD_DEFAULT STM32CUBE)

endif()