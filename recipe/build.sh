# *****************************************************************
#
# Licensed Materials - Property of IBM
#
# (C) Copyright IBM Corp. 2019, 2020. All Rights Reserved.
#
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
#
# *****************************************************************

export ONNX_ML=1
export CONDA_PREFIX="$PREFIX"  # build script looks at this, but not set on

python -m pip install --no-deps --ignore-installed --verbose .
