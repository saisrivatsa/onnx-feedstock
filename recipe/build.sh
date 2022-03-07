#!/bin/bash
# *****************************************************************
# (C) Copyright IBM Corp. 2019, 2022. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

export ONNX_ML=1
export CONDA_PREFIX="$PREFIX"  # build script looks at this, but not set on

if [[ $ppc_arch == "p10" ]]
then
    if [[ -z "${GCC_10_HOME}" ]];
    then
        echo "Please set GCC_10_HOME to the install path of gcc-toolset-10"
        exit 1
    else
        AR=${GCC_10_HOME}/bin/ar
        LD=${GCC_10_HOME}/bin/ld
        NM=${GCC_10_HOME}/bin/nm
        OBJCOPY=${GCC_10_HOME}/bin/objcopy
        OBJDUMP=${GCC_10_HOME}/bin/objdump
        RANLIB=${GCC_10_HOME}/bin/ranlib
        STRIP=${GCC_10_HOME}/bin/strip
    fi
fi

# Let's be explicit with CMake.
export CMAKE_ARGS="${CMAKE_ARGS} -DProtobuf_PROTOC_EXECUTABLE=$BUILD_PREFIX/bin/protoc -DProtobuf_LIBRARY=$PREFIX/lib/libprotobuf${SHLIB_EXT}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_AR=${AR}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_LINKER=${LD}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_NM=${NM}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_OBJCOPY=${OBJCOPY}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_OBJDUMP=${OBJDUMP}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_RANLIB=${RANLIB}"
export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_STRIP=${STRIP}"
python -m pip install --no-deps --ignore-installed --verbose .
