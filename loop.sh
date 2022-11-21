task=$RANDOM
task_log=task$task.log

path=`pwd`
cd $path

for n in `seq 0 6`;
do
    [ -s dockerPull.sh ] && bash dockerPull.sh && exit 0
    echo Loop begin >> $task_log
    date >> $task_log
    bash build.sh
    echo Loop end >> $task_log
    sleep 3600
done
