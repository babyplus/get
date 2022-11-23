. func.sh

registry="registry.cn-hangzhou.aliyuncs.com/babyplus"
echo Remote Registry: $registry
string=""

> dockerPull.sh
> dockerTag.sh

build $*
for n in `seq 0 6`
do
echo +++++++1
    bash dockerPull.sh && {
echo +++++++2
        mkdir -p records
        cat dockerPull.sh dockerTag.sh | sort -k 3 > records/`date +%s`
        exit 0
    }
    sleep 180
echo ++++==3
done

exit 1
