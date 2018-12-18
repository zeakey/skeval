#!/bin/bash
set -e
rm -rf .git
git init
git add -A
git add data/tiny-SK-LARGE -f
git add data/sk-results/tiny-fsds -f
git commit -m 'Reinitialized'
git remote add origin git@github.com:zeakey/skeval
git push -u origin master -f
echo "Done!"

