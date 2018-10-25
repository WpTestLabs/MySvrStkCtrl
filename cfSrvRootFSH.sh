# $Srv/env/cfSrvRootFSH.sh  20180817
# if [[ ! -z "$1" ]]; then export Srv=$1 ; fi << this file is sourced so can't OWN $1
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
export  SrvReq=$SrvLib/req
export  SrvWkFlo=$Srv/WkFlo
export  WkFloCmd=$SrvWkFlo/cmd
export  SrvWww=$Srv/www
export    WwwCDN=$SrvWww/CDN
export    WwwEtc=$SrvWww/etc
export      WwwSsl=$WwwEtc/letsencrypt/live
export      WwwLcl=$SrvWww/lcl
export      WwwLclAZ=$SrvWww/lclAZ
export      WwwLib=$SrvWww/lib
export      WpWwwLib=$WwwLib/WP
export        WwwLibWP=$WpWwwLib        # Deprecated @@@@ but still in WpRepoLib.sh
export        WwwLibWpPI=$WpWwwLib/PI   #   "  ==> WpWwwLib/{core,plugins,themes,__}
export    WwwPrfl=$SrvWww/Prfl
export    WwwSwcAZ=$SrvWww/swcAZ
export    WwwDflt=$SrvWww/default
export      WwwDfltLcl=$WwwDflt/lcl
export      WwwDfltSwc=$WwwDflt/www
  export  SvrStkN=gStkName
  export  SsRunHP=$Srv/run
  export  RunHP=$SsRunHP
