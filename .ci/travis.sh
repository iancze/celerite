#!/bin/bash -x

# If building the paper, do that here
if [[ $TEST_LANG == paper ]]
then
  if git diff --name-only $TRAVIS_COMMIT_RANGE | grep 'paper/'
  then
    echo "Building the paper..."
    export CELERITE_BUILDING_PAPER=true
    source "$( dirname "${BASH_SOURCE[0]}" )"/setup-texlive.sh
    return
  fi
  export CELERITE_BUILDING_PAPER=false
  return
fi

# If testing C++, deal with that here
if [[ $TEST_LANG == cpp ]]
then
  # Download the requested version of Eigen
  mkdir -p eigen
  cd eigen
  wget --quiet "http://bitbucket.org/eigen/eigen/get/${EIGEN_VERSION}.tar.gz"
  tar -xf ${EIGEN_VERSION}.tar.gz --strip-components 1
  cd ..

  # Build the tests
  cd cpp
  cmake . -DEIGEN_CHECK_INCLUDE_DIRS=../eigen
  make
  cd ..
  return
fi

# If we make it here then we're testing Python

# http://conda.pydata.org/docs/travis.html#the-travis-yml-file
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O miniconda.sh;
else
  wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
fi
bash miniconda.sh -b -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"

# Conda Python
hash -r
conda config --set always_yes yes --set changeps1 no
conda update -q conda
conda info -a
conda create --yes -n test python=$PYTHON_VERSION
source activate test
conda install -c conda-forge numpy=$NUMPY_VERSION setuptools eigen pybind11 pytest mkl

if [[ "$TRAVIS_OS_NAME" == "mkl" ]]; then
  conda install mkl
fi

# Build the extension
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  python setup.py install $BUILD_ARGS
else
  CXX=g++-4.8 CC=gcc-4.8 python setup.py install $BUILD_ARGS
fi
