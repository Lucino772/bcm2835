cmake_minimum_required(VERSION 3.10)

include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/get-version.cmake")

project(bcm2835 VERSION ${VERSION})

# Targets
set(TARGET bcm2835)
set(TEST_TARGET test_bcm2835)

## Library
# Source Files
set(bcm2835_src src/bcm2835.c)

# Headers file
set(bcm2835_h src/bcm2835.h)

# Add library target
add_library (${TARGET} SHARED ${bcm2835_src})

# Version
set_target_properties(${TARGET} PROPERTIES
                        VERSION ${PROJECT_VERSION}
                        SOVERSION ${PROJECT_VERSION_MAJOR})

# Add include directory for bcm2835
target_include_directories (${TARGET} PUBLIC 
                            ${CMAKE_CURRENT_SOURCE_DIR}/src
                            ${CMAKE_INSTALL_PREFIX}/include)

# Add the following required libraries: RealTime
target_link_libraries(${TARGET} rt)

# Add install
install(TARGETS ${TARGET} DESTINATION lib)
install(FILES ${bcm2835_h} DESTINATION include)

# CPack
set(CPACK_PACKAGE_NAME "bcm2835")
set(CPACK_PACKAGE_DESCRIPTION "C library for Broadcom BCM 2835 as used in Raspberry Pi ")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://github.com/Lucino772/bcm2835")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/COPYING")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README")

set(CPACK_GENERATOR "DEB")
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "bcm2835")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "armhf")

set(CPACK_SOURCE_GENERATOR "TGZ;ZIP")

include(CPack)

## Test
# Source Files
set(bcm2835_test_src src/test.c)
# Add test executable for library
add_executable(${TEST_TARGET} ${bcm2835_test_src})

# Add include directory for test_bcm2835
target_include_directories (${TEST_TARGET} PUBLIC 
                            ${CMAKE_CURRENT_SOURCE_DIR}/src
                            ${CMAKE_INSTALL_PREFIX}/include)

# Add the following required libraries for test: bcm2835
target_link_libraries(${TEST_TARGET} bcm2835)

# Add the following required libraries for test
target_link_libraries(${TEST_TARGET} ${TARGET})

# Add test
add_test(NAME test_library COMMAND ${TEST_TARGET})
include(CTest)
