. func.sh

registry="registry.cn-hangzhou.aliyuncs.com/babyplus"
echo Remote Registry: $registry
string=""

> dockerPull.sh
> dockerTag.sh

build $*
mkdir -p records
cat dockerPull.sh dockerTag.sh | sort -k 3 > records/`date +%s`
