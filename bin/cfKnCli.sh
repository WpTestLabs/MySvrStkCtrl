#!/bin/bash
# cfKnCli.sh
export KnCtrlBaseName=`basename $0` ;  			echo "	Start: $0 -> `readlink $0`"

declare -A NameMp     # Create an associative array
NameMp[ngx]=nginx
NameMp[sql]=mariadb
NameMp[php]=php
NameMp[php7]=php7 #  @@@@@ looks for php7 envRT but writes php @@@!! KnCtrlN vs KnPkgN!!!!
export KnCtrlN=${NameMp[$KnCtrlBaseName]};  echo "		Map: $KnCtrlBaseName --> $KnCtrlN"
command_not_found_handle () { echo "$KnCtrlBaseName: cmd not found >>>>>$1"; }
export EtcKnPFN=$Srv/etc/Knz/$KnCtrlN  # Well Known PFN for cur/default Kan Def  eg 'nginx'
export KnRtEnvPFN=$Srv/run/$KnCtrlN # Well Known PFN for RT.env (similar to PID file)
#tt	cat $KnRtEnvPFN

if [[ -e $KnRtEnvPFN ]]; then		echo "	$KnCtrlBaseName EnvRT - Found: $KnRtEnvPFN"
	. $KnRtEnvPFN; 		. $KnKlsPFN $@
else	echo "** Missing Kn RT Env file: $KnRtEnvPFN **"
	if [[ -e $EtcKnPFN ]]; 	then	
		echo -e "\nKanCrtl: $KnCtrlN -> $EtcKnPFN -> `readlink $EtcKnPFN`"
				. $EtcKnPFN; 	
				. $KnKlsPFN $@
	else
		echo "** Missing: $EtcKnPFN **"
	fi
fi
