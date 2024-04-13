cmake_minimum_required(VERSION 3.28)

project(MyProject LANGUAGES C)

include(GNUInstallDirs)
if(APPLE)
   set(base @loader_path)
else()
   set(base $ORIGIN)
endif()

set(CMAKE_INSTALL_RPATH ${base}/../${CMAKE_INSTALL_LIBDIR})

set(ZLIB_ROOT "${CMAKE_SOURCE_DIR}/deps-install/zlib")
set(PNG_ROOT "${CMAKE_SOURCE_DIR}/deps-install/libpng")

find_package(PNG REQUIRED)

add_executable(my_app my_app.c)
target_link_libraries(my_app PRIVATE PNG::PNG)

install(TARGETS my_app
    DESTINATION ${CMAKE_INSTALL_BINDIR}
    RUNTIME_DEPENDENCY_SET my_app_deps
)

install(RUNTIME_DEPENDENCY_SET my_app_deps
    PRE_EXCLUDE_REGEXES
        [[api-ms-win-.*]]
        [[ext-ms-.*]]
        [[kernel32\.dll]]
        [[libc\.so\..*]] [[libgcc_s\.so\..*]] [[libm\.so\..*]] [[libstdc\+\+\.so\..*]]
    POST_EXCLUDE_REGEXES
        [[.*/system32/.*\.dll]]
        [[^/lib.*]]
        [[^/usr/lib.*]]
)