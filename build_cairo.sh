#export CC=${toolchain}/bin/armv7a-linux-androideabi25-clang
#export CXX=${toolchain}/bin/armv7a-linux-androideabi25-clang++
export prefix=${DESKTOP_PREFIX}

cd cairo
./autogen.sh --host=${HOST} --prefix=${prefix} --enable-static
./autogen.sh --host=${HOST} --prefix=${prefix} --enable-static
./configure --host=${HOST} --prefix=${prefix} --enable-static
make install
git clean -xfd
cd ..
