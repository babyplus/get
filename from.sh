. list.txt
registry="registry.cn-hangzhou.aliyuncs.com/babyplus"
echo registry=$registry

> dockerPull.sh
> dockerTag.sh

gen()
{
  random=`echo $RANDOM | md5sum |cut -c 1-5`
  
  var=$1
  
  sw=${var##*/}
  
  version=`echo $sw |awk -F : '{print $2}'`
  version=`echo $version|sed 's/\./_/g'`
  
  sw=`echo $sw|awk -F : '{print $1}'`
  sw=`echo $sw|sed 's/\./_/g'|sed 's/-/_/g'`
  
  echo $random.$sw.$version
  return $random.$sw.$version
}

main()
{
  for n in ${list[@]}
  do
    echo FROM $n > Dockerfile
    tag=`gen $*`
    git add .
    git commit -m "release-v$tag $n"
    git tag release-v$tag
    git push --tags
    echo docker pull $registry/get:$tag  >>dockerPull.sh
    echo docker tag $registry/get:$tag $n  >>dockerTag.sh
    sleep 30
  done
}

main $*
