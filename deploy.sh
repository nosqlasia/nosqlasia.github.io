#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

git checkout source
git pull origin source
git add -A
git commit -m 'committing work in progress'

# Pull down the file we just committed. This helps avoid merge conflicts
git subtree pull --prefix=public origin master -m 'merge origin'

# Build the project.
hugo -t hyde-x

# Add the CNAME
touch public/CNAME
echo "life.beyondrails.com" > public/CNAME

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin source
git subtree push --prefix=public gitt@github.com:nosqlasia/nosqlasia.github.io.git master
