if [ -d build ];
then
    rm -rf build
fi 
cmake -S . -B build -D CMAKE_TOOLCHAIN_FILE=../windows.cmake && cd build && make 