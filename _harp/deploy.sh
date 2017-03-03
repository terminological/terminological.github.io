#!/bin/bash

harp compile . ..

cd ..
git add -A
git commit -a -m 'autocommit'
git push origin master

