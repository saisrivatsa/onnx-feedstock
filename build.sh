set -xe

mkdir onnx-prefix

repo=https://github.com/onnx/onnx
branch=v1.16.0

git clone -b $branch $repo

cd onnx

git submodule update --init --recursive

export ONNX_ML=1
export PREFIX=$(pwd)/../onnx-prefix
export CONDA_PREFIX="$PREFIX"
export gcc_home=/opt/rh/gcc-toolset-12/root/usr

if [[ $ppc_arch == "p10" ]]
then
   AR=$gcc_home/bin/ar
   LD=$gcc_home/bin/ld
   NM=$gcc_home/bin/nm
   OBJCOPY=$gcc_home/bin/objcopy
   OBJDUMP=$gcc_home/bin/objdump
   RANLIB=$gcc_home/bin/ranlib
   STRIP=$gcc_home/bin/strip
fi

export CMAKE_ARGS=""
export CMAKE_ARGS="${CMAKE_ARGS} -DONNX_USE_LITE_PROTO=ON"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_AR=${AR}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_LINKER=${LD}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_NM=${NM}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_OBJCOPY=${OBJCOPY}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_OBJDUMP=${OBJDUMP}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_RANLIB=${RANLIB}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_STRIP=${STRIP}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=$PREFIX"

python -m pip wheel -w dist -vv .
