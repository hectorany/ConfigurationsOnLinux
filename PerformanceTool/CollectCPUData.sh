#!/usr/bin/bash
set -x

PID=''
DIAMETER='FALSE'
OUTPUT='AllCPUDATA.txt'
TIMESLOT=1
TIMELONG=30
INSTANCE=''

function usage()
{
	echo "./CollectCPUData.sh -p PID [-d] [-o OutputFile] [-i InstanceName]"
	exit 
}

if [ $# -lt 1 ]
then
	usage
fi


while getopts p:do:i: OPTION
do
	case $OPTION in
	p) 
		PID=$OPTARG
		;;
	d)
		DIAMETER='TRUE'
		;;
	o)
		OUTPUT=$OPTARG
		;;
	i)
		INSTANCE=$OPTARG
		;;
	:)
		echo "The option -$OPTARG requires an argument."
		usage
		exit 1
		;;
	?)
		echo "Invalid option: -$OPTARG"
		usage
		exit 2
		;;
	esac
done

echo "Collection TelicaDC with PID $PID"
echo "DIAMETER=$DIAMETER"
echo "OutputFile=$OUTPUT"

HTOPORIGFILE="tempHTop.$PID"
TOPORIGFILE="tempTop.$PID"
DATASPACEFILE="dataSpace.$PID"


function HtopB()
{
	top -H -p $1 -n $TIMELONG -d $TIMESLOT -b >$2
}

function topB()
{
	top -p $1 -n $TIMELONG -d $TIMESLOT -b >$2
}

function dataSpace()
{
	let count=$TIMELONG/$TIMESLOT
	let i=0
	echo "CacheSpace" > $DATASPACEFILE
	while (( $i<$count ))
	do
		let i++
		sleep $TIMESLOT
		du -l --max-depth=0 /opt/PlexDC/$INSTANCE/data/* |awk 'BEGIN{sum = 0;}{sum += $1} END{printf "%.4f",sum/1024}' >> $DATASPACEFILE
	done
}

HtopB $PID $HTOPORIGFILE &
topB $PID $TOPORIGFILE &
dataSpace &

wait

BILLFILE="BillingactvTsk.$PID"
echo 'billingActvTsk' > $BILLFILE
STATSFILE="StatsDB.$PID"
echo 'StatsDB' > $STATSFILE
RECEIVERFILE="ReceiverHandler.$PID"
echo 'receiverHandler' > $RECEIVERFILE
SENDACRFILE="sendACRHndl.$PID"
MAINFILE="TelicaMain.$PID"
echo 'TelicaMain' > $MAINFILE


grep billingActvTsk $HTOPORIGFILE |awk '{print $9}' >> $BILLFILE &
grep StatsDB $HTOPORIGFILE|grep -v BGPersi |awk '{print $9}' >> $STATSFILE &
grep receiverHandler $HTOPORIGFILE |awk '{print $9}' >> $RECEIVERFILE &
grep Telica $TOPORIGFILE |awk '{print $9}' >> $MAINFILE &

if [ $DIAMETER='TRUE' ]
then 
	echo 'sendACRHndl' > $SENDACRFILE
	grep sendACRHndl $HTOPORIGFILE |awk '{print $9}' >> $SENDACRFILE &
	wait
	paste $MAINFILE $STATSFILE $BILLFILE $RECEIVERFILE $SENDACRFILE $DATASPACEFILE > $OUTPUT
else
	paste $MAINFILE $STATSFILE $BILLFILE $RECEIVERFILE $DATASPACEFILE > $OUTPUT
fi

rm -rf *.$PID
