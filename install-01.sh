#!/bin/sh
#   echo "https://github.com/WpTestLabs/MySvrStkCtrl/install-01.sh"
install -pm 644 -o root -g root -t $Srv/env  cfSrvRootFSH.sh
ln -srf $Srv/env/cfSrvRootFSH.sh $Srv/env/cfSrvRootFSH.env && . $Srv/env/cfSrvRootFSH.env
install -pm 740 -o root -g root -t $Srv  my.sh myEnv.sh
ln -srf $Srv/my.sh $Srv/my
cd bin && install -pm 740 -o root -g root -t $SrvBin  cfKnCli.sh
cd ../lib && install -pm 640 -o root -g root -t $SrvLib cfDkrCtrlLib.sh
