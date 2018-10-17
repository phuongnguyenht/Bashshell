#!/bin/bash

cd /opt/
find . -maxdepth 1 -name "*.txt" -mmin +40 -exec mv {} /opt/backup/{} \;
