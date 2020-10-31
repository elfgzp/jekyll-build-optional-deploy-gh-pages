#!/bin/sh

gem install bundler:1.16.5
bundle install
bundle exec jekyll build
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git checkout --orphan gh-pages
cp ads.txt build/
cd build/
touch .nojekyll
remote_repo="https://x-access-token:${GH_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" && \

git init && \
git config user.name "${GITHUB_ACTOR}" && \
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com" && \
git add . && \

echo -n '[!] - Files to Commit:' && ls -l | wc -l && \

git commit -m'action build'
git push --force $remote_repo master:gh-pages

rm -fr .git && \

cd ../

