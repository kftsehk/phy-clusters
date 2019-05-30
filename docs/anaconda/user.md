# Introduction

Anaconda is a package manager that allows user to **install package in user's own directory without using root**.

A list of commonly used, up-to-date packages are provided in the `base` environment. New users can start with these defaults and customize as needed.

### C/Fortran Development

Name | Version | Build | Channel
--- | --- | --- | ---
automake | 1.16.1 | pl526_0
babel | 2.6.0 | py37_0
cmake | 3.14.0 | h52cb24c_0
gawk | 4.2.1 | h14c3975_0
git | 2.20.1 | pl526hacde149_0
gcc_linux-64 | 7.3.0 | h553295d_7
gfortran_linux-64 | 7.3.0 | h553295d_7
gxx_linux-64 | 7.3.0 | h553295d_7
make | 4.2.1 | h1bed415_1

### Python Development

Name | Version | Build | Channel
--- | --- | --- | ---
ipython | 7.4.0 | py37h39e3cac_0
jupyter | 1.0.0 | py37_7
matplotlib | 3.0.3 | py37h5429711_0
numpy | 1.16.2 | py37h7e9f1db_0
pandas | 0.24.2 | py37he6710b0_0
pip | 19.0.3 | py37_0
python | 3.7.3 | h0371630_0
scipy | 1.2.1 | py37h7c811a0_0

### General

Name | Version | Build | Channel
--- | --- | --- | ---
ca-certificates | 2019.3.9 | hecc5488_0 | conda-forge
bash | 4.4.18 | h67949de_1000 | conda-forge
gnuplot | 5.2.6 | h213187a_1 | conda-forge
openssl | 1.1.1b | h14c3975_1 | conda-forge

### Java Development

Name | Version | Build | Channel
--- | --- | --- | ---
openjdk | 8.0.152 | h46b5887_1

### Numerical Libraries

Name | Version | Build | Channel
--- | --- | --- | ---
blas | 1.0 | mkl
hdf5 | 1.10.4 | hb1b8bf9_0
intel-openmp | 2019.3 | 199
mkl | 2019.3 | 199

# Usage

## Basics
To activate an environment
```
conda activate <env-name
```
To deactivate an environment
```
conda activate
```

## Install your own package
The `base` environment is owned by `root`, you must create your own environment to install custom packages, including download new python packages using pip. In the example below, an environment owned by you, named `myenv`, will be created.
### Create an environment you own
This example creates a clone of `base` that is owned by you
```
conda env create --name myenv --clone base
```
This example creates a new python2 enviornment
```
conda env create --name myenv python=2
```
### Switch to your environment
```
conda deactivate
conda activate myenv
```
### Install packages for your environment
```
conda install <some-package>
pip install <some-pip-package>
```
[Reference](https://conda.io/docs/user-guide/tasks/manage-environments.html)
