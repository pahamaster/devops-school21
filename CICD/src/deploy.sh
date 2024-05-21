#!/bin/bash

scp -P 2022 build/s21_cat paha@10.10.0.2:~/
scp -P 2022 build/s21_grep paha@10.10.0.2:~/
ssh -p 2022 paha@10.10.0.2 "echo "123" | sudo -S mv s21_cat s21_grep /usr/local/bin"