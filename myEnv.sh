#!/bin/bash
   echo "   >> Start myEnv.sh PWD: $PWD    Srv: $Srv"
export PS1="\[\033[1;33m\]<CF> \$Srv \[\033[0;36m\][\w]\\$\[\033[0m\] "
export DbSrvHst=127.0.0.1  # ==> SrvStk.env
export WpDlUrl=https://wordpress.org
export WpPiDlUrl=https://downloads.wordpress.org/plugin
.  $Srv/env/cfSrvRootFSH.env

lsc () { ls --color=auto $@; }

command_not_found_handle () { echo "myEnv.sh >> cmd not found >>>>> $1"; 
    echo "myEnv.sh - \$SsRunHP >> $SsRunHP"
    export KnCtrlBaseName=$1 ;  shift;
    export KnRtEnvPFN=$SsRunHP/$KnCtrlBaseName
    if [[ -e $KnRtEnvPFN ]]; then . $KnRtEnvPFN; . $KnKlsPFN $@; exit; fi
    export EtcKnPFN=$SrvEtcKnz/$KnCtrlBaseName 
    if [[ -e $EtcKnPFN ]]; then . $EtcKnPFN; . $KnKlsPFN $@; exit; fi
    echo "*** END command_not_found_handle() ****"
}
#env
if [[ -z "$1" ]]; then /bin/sh; else $@; fi
