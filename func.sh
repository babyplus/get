gen()
{
  random=`echo $RANDOM | md5sum |cut -c 1-5`

  var=$1

  sw=${var##*/}

  version=`echo $sw |awk -F : '{print $2}'`
  version=`echo $version|sed 's/\./_/g'`

  sw=`echo $sw|awk -F : '{print $1}'`
  sw=`echo $sw|sed 's/\./_/g'|sed 's/-/_/g'`

  today=`date +%y%m%d`
  
  echo $today$random.$sw.$version
  string=$today$random.$sw.$version
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

accelerate_pro()
{
  for n in ${list[@]}
  do
    echo FROM $n > Dockerfile
    > dockerPull.current.sh
    > dockerTag.current.sh
    > dockerPull.previous.sh
    > dockerTag.previous.sh
    for l in `seq 0 6`
    do
	[ -s dockerPull.previous.sh ] && bash dockerPull.previous.sh && {
            cat dockerPull.previous.sh >>dockerPull.sh
            cat dockerTag.previous.sh >>dockerTag.sh
            break
        }
        sleep 10
	[ -s dockerPull.current.sh ] && bash dockerPull.current.sh && {
            cat dockerPull.current.sh >>dockerPull.sh
            cat dockerTag.current.sh >>dockerTag.sh
            break
        }
        gen $n
        tag=$string
        git add .
        git commit -m "release-v$tag $n"
        git tag release-v$tag
        git push --tags
        cp dockerPull.current.sh dockerPull.previous.sh
        cp dockerTag.current.sh dockerTag.previous.sh
        echo docker pull $registry/get:$tag >dockerPull.current.sh
        echo docker tag $registry/get:$tag $n >dockerTag.current.sh
        sleep 300
    done
  done
}
