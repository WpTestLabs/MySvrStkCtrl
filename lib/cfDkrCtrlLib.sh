#!/bin/bash
# echo "start: /srv/lib/cfDkrCtrlLib.sh"; ### -- Start Dkr generic Kn Control
KnId2Status () { docker ps -a --filter id=$CID --format "{{.Status}}" ; }
LstKnNames () { docker ps -a --filter label=kanT=$KnPkgN --format "{{.Names}}"; }
LstKnSts () { docker ps -a --filter label=kanT=$KnPkgN --format "{{.Names}} {{.Status}}"; }
Status () {	echo "___ - Status()...";  LstKnSts; }
DkrCmd2CID () { local c=$1; shift;	
	if [[ ! -z $CID ]]; then 	echo "  >> DkrCmd2CID - cmd: $1  CID: $CID  $2 $3 <<"
		docker $c $CID $@
	else   echo "  ** DkrCmd2CID - cmd: $1  CID is Empty! **"
	fi
} #---- #my () {  DkrCmd2CID "exec -it" /srv/www/php/my.sh  $@; }
args () { echo $@; }
Logs () { DkrCmd2CID logs ; }
Term () {  DkrCmd2CID "exec -it" /bin/sh $@; } #!in Alp img!  htop () { DkrCmd2CID ...
knPs () { DkrCmd2CID "exec -it" ps -ef; }
ps () { knPs; } # ------
pCfRunLnk () {
cat <<EOF
	echo "Start: $RunFQHPFN"
# This file: $RunFQHPFN
export CID=$1

. $ThisKnCtrlHPFN \$@
EOF
} #----
probe () {  local pfn=$1;  #### @@@@@ $1 ***UNTESTED***
	if [[ -z "$pfn" ]]; then  	local ts=`date +%y%m%d-%H%M`;  			echo "ts: $ts"
		local tp="Export_${ts}_XXX" ;						echo "tp: $tp"
		pfn=/tmp/`mktemp -d $tp` 
	fi
	docker run -it --rm -v $pfn:/Export $DkrRtImgN ${1-/bin/sh}; 
	echo -e "\nFQ Export Path: $pfn\n`ls -al $pfn`"
}
_pDkrRunD () { #         $FQKanRtN  ==> $FQKnRtN  20180329 @@@@@@@@@@@@@@@@@@@@
cat <<EOF
docker run -d --name $FQKnRtN  $DkrRtLbls  $DkrVolGrp  $DkrNet  $DkrRtImgN $DkrRunDCmd
EOF
} #----
_Run () {  # See On() which adds chk: Already running?? (Paused? Stopped?)
	mkdir -p $RunHP;					_pDkrRunD
	cmd=$(_pDkrRunD)
	export S=`$cmd` R=$?;    			echo -e "result>>$S\nExit Code: $R"
	if [[ $R -eq 0 ]];  then			echo " -- Success - CID: $S"
		pCfRunLnk $S > $RunFQHPFN;		cat $RunFQHPFN
    else		echo " -- Error Code: $R"
	fi
} #----
Run () { _Run ; } # for overrides!  #RunIT () { }
On () {	echo "$KnCtrlBaseName.On() - CID: $CID"
	local knSts=`KnId2Status`;			echo "len: ${#knSts}"
	#  ${filename%.*}		#	echo "1>${knSts%.[[:space:]]}"
	if [[ ${#knSts} -gt "0" ]]; then
		local L2=${knSts:0:2}
#	echo "1>${knSts%}"  #	echo ">>>${knSts:0:2}<<<"  	#echo "L2>>$L2<<"
		if [[ 'Up' = "$L2" ]]; then
			echo "  >> Up & __ <<"
			if [[ "$knSts" =~ "(Paused)" ]]; then	echo "  >> Paused << ";
				  DkrCmd2CID unpause
			else	echo "  >> Running <<";
			fi
		else
			if [[ 'Ex' = "$L2" ]]; then		echo "  >> Exited <<"
				DkrCmd2CID restart
			else	echo "  Unknown Status >>>>$knSts<<   L2 >>$L2<<<<"
			fi
		fi
	else	echo "knSts length is zero! -- No matching Kn found for CID: $CID"
		Run
	fi
} #----
Rm () {	local lst=`LstKnNames -a`;  # @@ ???? DkrRm Lst??
	if [[ ! -z $lst ]]; then echo -e "Kn Img(s) found: \n$lst\nDocker removing kn imgs..."
		docker rm $lst;		rm -f $RunFQHPFN
	else	echo "No Kan Images found for Kan type: $KnPkgN"
	fi
} #----
DkrStop () {	local lst=`LstKnNames`;  echo "Stopping Kan type: $KnPkgN"
	if [[ ! -z $lst ]]; then	echo "Active Kans: "  $lst; echo "Docker killing..."
		docker kill $lst
	else	echo "No Active Kans for Kan type: $KnPkgN"
	fi
	echo "---"; Rm
}
mounts () {
cat <<EOF

$KnPkgN Mounts - Kn Guest -> Host
/etc/$KnPkgN -> $KnEtcHP
/var/log/$KnPkgN -> $KnLogHP
/srv/www -> $KnDatHP

EOF
}
doCli () {
if [[ -z $1 ]]; then	echo -e "No command given, running default...\n-- By CID:"
	KnId2Status | grep ^Up ; echo $?
	knSts=`KnId2Status`
	echo $knSts;  echo "-- All running of type: $KnPkgN";		Status
else 	$@
fi
}
