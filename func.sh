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
  string=$random.$sw.$version
  return 0
}

build()
{
  [ $# -lt 1 ]&&{
    echo
    echo USAGE: $0 TARGET_TAG
    echo
    echo ...exit
    echo
    exit 1
  }
  n=$1
  gen $n
  tag=$string
  git add .
  git commit -m "release-v$tag $n"
  git tag release-v$tag
  git push --tags
  echo docker pull $registry/get:$tag  >>dockerPull.sh
  echo docker tag $registry/get:$tag $n  >>dockerTag.sh
  sleep 30
}

accelerate()
{
  for n in ${list[@]}
  do
    echo FROM $n > Dockerfile
    gen $n
    tag=$string
    git add .
    git commit -m "release-v$tag $n"
    git tag release-v$tag
    git push --tags
    echo docker pull $registry/get:$tag  >>dockerPull.sh
    echo docker tag $registry/get:$tag $n  >>dockerTag.sh
    sleep 30
  done
}
