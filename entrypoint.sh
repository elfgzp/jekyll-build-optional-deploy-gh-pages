#!/bin/sh

gem install bundler:1.16.5
bundle install
bundle exec jekyll build
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
git config credential.helper "store --file=.git/credentials"
echo "https://${GH_TOKEN}:@github.com" > .git/credentials
git add .
git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
git push origin gh-pages -f
git push -f --mirror https://elf_gzp:${GITEE_TOKEN}@gitee.com/elf_gzp/elfgzp.cn.git

rm -fr .git && \

cd ../

