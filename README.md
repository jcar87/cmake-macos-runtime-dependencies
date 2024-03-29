# cmake-macos-runtime-dependencies
Repro to test CMake GET_RUNTIME_DEPENDENCIES on macOS

```
git clone https://github.com/jcar87/conan-cmake-install-runtime-dependencies.git
cd conan-cmake-install-runtime-dependencies 

./build-deps.sh
cmake -S . -B build/ -DCMAKE_BUILD_TYPE=Release
cmake --build build/
cmake --install build/ --prefix=$(pwd)/bundle
```

This fails with error:
```
CMake Error at build/cmake_install.cmake:55 (file):
  file Could not resolve runtime dependencies:

    @rpath/libz.1.dylib
```

