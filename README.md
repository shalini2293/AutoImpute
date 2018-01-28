# AutoImpute
## About
Auto-encoder based gene-expression (sparse) matrix imputation, where the columns of the matrix represent the genes and the rows represent the individual cells.

## Dependencies
* For Python code:
    * numpy
    * scikit-learn
    * tensorflow
    * matplotlib
* For Matlab analysis code:
    *  Propack
    *  sparco

## Contents
* `Autoencoder Scripts / Imputation` - contains the python scripts used for the sparse matrix imputation.
* `Autoencoder Scripts / Masked Matrix Analysis` - contains the python scripts used for masked matrix analysis part.
* `Matlab Analysis Scripts` - contains the matlab scripts used for analysis.
## Input description
The input is a pre-processed count single cell data. The preprocessing steps are mentioned in the paper: "AutoImpute : Autoencoder based imputation of single cell RNA-seq data".

## Execution
* Change the paths in the scripts s.t. they point to the preprocessed version of the data (as described in the input subsection).
* Open terminal, and `cd` into the respective directory.
* run the python scripts for a specific dataset using the following command :
    * `python autoencoder_<dataset name>.py --debug <want debug statements "yes"/"no"?>` - for scripts in imputation folder.
    * `python autoencoder_<dataset name>.py --mask <masking value> --debug <want debug statements "yes"/"no"?>` - for scripts in masked matrix analysis folder.

## Contributors
* Divyanshu Talwar
* Aanchal Mongia
* Viraj Parimi
* Debarka Sengupta
* Angshul Majumdar