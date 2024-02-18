cmake_minimum_required(VERSION 3.19)
cmake_policy(VERSION 3.19)

#### Initialize Mbed OS build system. ####
######################################################################################################
### Block of including .json files. Files of this block must be included before the app.cmake

#[[ Set path of mbed_app.json (necessary everytime if mbed_app.json is in project) ]]
set(MBED_APP_JSON_PATH mbed_app.json5)

###--------------------------------------------------------------------------------------------------- 
#[[ This part is intended to custom targets and activates the custom_targets.json 
and upload method config otherwise functions below should be commented ]]

#[[ Here set path for custom_targets.json (this is our default) ]]
 set(CUSTOM_TARGETS_JSON_PATH custom_targets/custom_targets.json5) 

 #[[ Note: For custom target you need also an upload method and we have few options how you can do that
    - use the variable CUSTOM_UPLOAD_CFG_PATH below
    - use default expected path for custom targets upload methods where you create your own config
      MY_PROJECT/custom_targets/upload_method_cfg

    For regular targets we have note you an check for an insperation
    https://github.com/mbed-ce/mbed-os/tree/master/targets/upload_method_cfg ]]

#[[ Here you can set path for custom upload config .cmake (optional example) ]]
# set(CUSTOM_UPLOAD_CFG_PATH ${CMAKE_SOURCE_DIR}/${MBED_TARGET}/${MBED_TARGET}.cmake)

### End of block
######################################################################################################

### include app.cmake (necessary everytime) ###
include(mbed-os/tools/cmake/app.cmake)

######################################################################################################
### Block of including project folders

#[[ In case of custom targets must be the folder included before mbed-os subdirectory
otherwise should be the next line commented]]
add_subdirectory(custom_targets)

###--------------------------------------------------------------------------------------------------
## Add mbed-os subdirectory (necessary everytime)
add_subdirectory(mbed-os)

###--------------------------------------------------------------------------------------------------
## Add another subdirectory, for example subdirectory of a library (if needed)
#add_subdirectory(YourLibrary)

### End of block
######################################################################################################

### Set up your project name (necessary everytime)
project(mbed-ce-custom-targets)


### add executable (necessary everytime)
add_executable(main main.cpp)

######################################################################################################
### Link libraries block

#[[For more about this configuraion visit wiki page
https://github.com/mbed-ce/mbed-os/wiki/MbedOS-configuration#configuration-via-cmake-files]]

#[[link MbedOS and its libraries (necessary everytime)]]
target_link_libraries(main  mbed-os) 

### link user library (if needed)
#target_link_libraries(main YourLibrary) 

### End of block
######################################################################################################

### Set post build (necessary everytime)
mbed_set_post_build(main)

### Build finalize does necessary configuration for debug in most cases (necessary everytime)
mbed_finalize_build()