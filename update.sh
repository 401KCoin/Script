#/bin/bash

cd ~
echo "****************************************************************************"
echo "* Ubuntu 16.04 is the recommended opearting system for this install.       *"
echo "*                                                                          *"
echo "* This script will install and configure your 401K Coin seednodes.         *"
echo "****************************************************************************"
echo && echo && echo
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!                                                 !"
echo "! Make sure you double check before hitting enter !"
echo "!                                                 !"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo && echo && echo

## COMPILE AND INSTALL
wget https://github.com/401KCoin/Script/raw/master/401kcoin-cli
wget https://github.com/401KCoin/Script/raw/master/401kcoin-tx
wget https://github.com/401KCoin/Script/raw/master/401kcoind

sudo chmod 755 401kcoin*
sudo cp 401kcoin* /usr/bin
sudo mv 401kcoin* /usr/local/bin

401kcoind
