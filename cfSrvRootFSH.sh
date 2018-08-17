# $Srv/env/cfSrvRootFSH.sh  20180817
if [[ ! -z "$1" ]]; then export Srv=$1 ; fi
if [[ -z "$Srv" ]]; then export Srv=/srv ; fi

export  SrvBin=$Srv/bin
export    SrvBldTmp=$Srv/BldTmp
export  SrvEnv=$Srv/env
export  SrvEtc=$Srv/etc
export    SrvEtcKnz=$SrvEtc/Knz  
export  SrvKnz=$Srv/Knz
export  SrvLib=$Srv/lib
export     CfLib=$SrvLib/CldFns
export  SrvLog=$Srv/log
export  SrvRepo=$Srv/Repo
export    WpRepo=$SrvRepo/WP
export  SrvWww=$Srv/www
export    WwwCDN=$SrvWww/CDN
export    WwwEtc=$SrvWww/etc
export      WwwSsl=$WwwEtc/letsencrypt/live
export      WwwLcl=$SrvWww/lcl
export      WwwLclAZ=$SrvWww/lclAZ
export      WwwLib=$SrvWww/lib
export        WwwLibWP=$WwwLib/WP
export        WwwLibWpPI=$WwwLibWP/PI
export    WwwPrfl=$SrvWww/Prfl
export    WwwSwcAZ=$SrvWww/swcAZ
export    WwwDflt=$SrvWww/default
export      WwwDfltLcl=$WwwDflt/lcl
export      WwwDfltSwc=$WwwDflt/www
  export  SvrStkN=gStkName
  export  SsRunHP=$Srv/run
  export  RunHP=$SsRunHP