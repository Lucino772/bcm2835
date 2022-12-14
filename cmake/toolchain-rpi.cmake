set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

if (NOT DEFINED ENV{TOOLCHAIN_PATH})
    message(SEND_ERROR "Missing environment variable 'TOOLCHAIN_PATH'")
endif()

set(TOOLCHAIN_PATH $ENV{TOOLCHAIN_PATH})
set(TOOLCHAIN_PREFIX arm-none-linux-gnueabihf)

set(CMAKE_AR                        ${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}-ar)
set(CMAKE_ASM_COMPILER              ${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_C_COMPILER                ${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_CXX_COMPILER              ${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}-g++)
set(CMAKE_LINKER                    ${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}-ld)
set(CMAKE_OBJCOPY                   ${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}-objcopy CACHE INTERNAL "")
set(CMAKE_RANLIB                    ${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}-ranlib CACHE INTERNAL "")
set(CMAKE_SIZE                      ${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}-size CACHE INTERNAL "")
set(CMAKE_STRIP                     ${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}-strip CACHE INTERNAL "")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
