cmake_minimum_required(VERSION 3.26)
project(sabine C)

set(CMAKE_C_STANDARD 23)

include_directories(./include)

include_directories($ENV{LD_LIBRARY_PATH})

include_directories($ENV{NIX_LIBSABINE_HEADER})

file(
  GLOB SABINE_SRC CONFIGURE_DEPENDS
  "include/*.h"
  "src/*.c"
)

add_executable(sabine ${SABINE_SRC})

find_library(SABINE_LIB sabine HINTS $ENV{LD_LIBRARY_PATH})

if(SABINE_LIB)
    target_link_libraries(sabine PRIVATE ${SABINE_LIB})
else()
    message(FATAL_ERROR "libsabine not found!")
endif()

set(CMAKE_BUILD_TYPE Debug)

install(TARGETS sabine DESTINATION bin)
