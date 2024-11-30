#!/bin/bash

conda create --name main python=3.10
conda activate main
conda install pandas numpy sqlite gzip 
pip install liftover
