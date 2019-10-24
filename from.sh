. list.txt
registry="registry.cn-hangzhou.aliyuncs.com/babyplus"
echo registry=$registry
for n in ${list[@]}
do
  echo FROM $n > Dockerfile
  read -p "$n --->" tag
  git add .
  git commit -m "release-v$tag $n"
  git tag release-v$tag
  git push --tags
  echo docker pull $registry/get:$tag
  echo docker tag $registry/get:$tag $n
done
