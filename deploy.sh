#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git add -A
git commit -m 'deploy'

git push -f https://github.com/NTUT-NPC/vue-tutorial-todo.git master:gh-pages

cd -