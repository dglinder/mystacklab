#!/bin/bash

# 1: Setup ssh keys if needed
for X in git jenkins tower ; do
  cd ${X}
  ssh-keygen -f ${X}_key
  cd ..
done
