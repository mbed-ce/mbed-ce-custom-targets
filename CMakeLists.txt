cmake_minimum_required(VERSION 3.19)
cmake_policy(VERSION 3.19)

#### Initialize Mbed OS build system. ####
######################################################################################################

#[[ Set path of mbed_app.json (necessary at all times) ]]
set(MBED_APP_JSON_PATH mbed_app.json5)

###--------------------------------------------------------------------------------------------------- 
#[[ This part is dedicated for custom targets only! Settings below activate targets from
    custom_targets.json5 and upload method config, otherwise lines below should be commented. ]]

#[[ Here set path for custom_targets.json5 (this is our default) ]]
 set(CUSTOM_TARGETS_JSON_PATH custom_targets/custom_targets.json5)

#[[ Here you can set path for custom upload config.
    You may delete this line if you don't wish to use Mbed CE upload methods
    in your project.]]
set(CUSTOM_UPLOAD_CFG_PATH custom_targets/CustomUploadMethods.cmake)

   
### End of block
######################################################################################################

### include app.cmake (necessary everytime) ###
include(mbed-os/tools/cmake/app.cmake)

######################################################################################################
### Block of including project folders

#[[ Add custom targets subdir first, before mbed-os!]]
add_subdirectory(custom_targets)

###--------------------------------------------------------------------------------------------------
## Add mbed-os subdirectory next (necessary everytime)
add_subdirectory(mbed-os)

###--------------------------------------------------------------------------------------------------
## Add another subdirectory, for example subdirectory of a library (if needed)
#add_subdirectory(YourLibrary)

### End of block
######################################################################################################

### Set up your project name (necessary everytime)
project(mbed-ce-custom-targets)

### add executable (necessary everytime)
add_executable(${CMAKE_PROJECT_NAME} main.cpp)

######################################################################################################
### Link libraries block
#[[For more about this configuration visit wiki page MbedOS-configuration
https://github.com/mbed-ce/mbed-os/wiki/MbedOS-configuration#configuration-via-cmake-files]]

#[[link MbedOS and its libraries (necessary everytime)]]
target_link_libraries(${CMAKE_PROJECT_NAME}  mbed-os) 

### link user library (if needed)
#target_link_libraries(${CMAKE_PROJECT_NAME} YourLibrary) 

### End of block
######################################################################################################

### Set post build (necessary everytime)
mbed_set_post_build(${CMAKE_PROJECT_NAME})

#[[ Note: if you wish to use a custom linker script instead of the default Mbed one for
   your target, you can do that with mbed_set_post_build(${CMAKE_PROJECT_NAME} path/to/linker_script.ld) ]]

### Call this last, after creating all targets.  It writes out IDE configuration files
### so that you can run your targets in VS Code.
mbed_finalize_build()
