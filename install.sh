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

echo "Do you want to install all needed dependencies (no if you did it before)? [y/n]"
read DOSETUP

if [[ $DOSETUP =~ "y" ]] ; then
  sudo apt-get update
  sudo apt-get -y upgrade
  sudo apt-get -y dist-upgrade
  sudo apt-get install -y nano htop git
  sudo apt-get install -y software-properties-common
  sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
  sudo apt-get install -y libboost-all-dev
  sudo apt-get install -y libevent-dev
  sudo apt-get install -y libminiupnpc-dev
  sudo apt-get install -y autoconf
  sudo apt-get install -y automake unzip
  sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
  sudo apt-get update
  sudo apt-get install -y libdb4.8-dev libdb4.8++-dev

  cd /var
  sudo touch swap.img
  sudo chmod 600 swap.img
  sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
  sudo mkswap /var/swap.img
  sudo swapon /var/swap.img
  sudo free
  sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
  cd

  mkdir -p ~/bin
  echo 'export PATH=~/bin:$PATH' > ~/.bash_aliases
  source ~/.bashrc
fi

## COMPILE AND INSTALL
CONF_DIR=~/.401kcoin/
mkdir $CONF_DIR
CONF_FILE=401kcoin.conf

## BACKUP WALLET AND MASTERNODE
sudo cp $CONF_DIR/wallet.data ~/
sudo cp $CONF_DIR/masternode.conf ~/
sudo cp $CONF_DIR/$CONF_FILE.conf ~/

## IP=$(curl -s4 icanhazip.com)

echo "listen=1" >> $CONF_DIR/$CONF_FILE
echo "server=1" >> $CONF_DIR/$CONF_FILE
echo "daemon=1" >> $CONF_DIR/$CONF_FILE
echo "staking=0" >> $CONF_DIR/$CONF_FILE
echo "addnode=178.128.145.147" >> $CONF_DIR/$CONF_FILE
echo "addnode=167.99.45.10" >> $CONF_DIR/$CONF_FILE
echo "addnode=139.59.74.84" >> $CONF_DIR/$CONF_FILE
echo "addnode=206.189.58.59" >> $CONF_DIR/$CONF_FILE
echo "addnode=178.128.194.194" >> $CONF_DIR/$CONF_FILE
echo "addnode=206.189.126.13" >> $CONF_DIR/$CONF_FILE
# echo "addnode=139.59.56.40" >> $CONF_DIR/$CONF_FILE
# echo "addnode=167.99.64.179" >> $CONF_DIR/$CONF_FILE
# echo "addnode=159.65.143.31" >> $CONF_DIR/$CONF_FILE
# echo "addnode=188.166.82.245" >> $CONF_DIR/$CONF_FILE
# echo "addnode=138.68.9.80" >> $CONF_DIR/$CONF_FILE

401kcoind
