#/bin/bash

cd ~
echo "****************************************************************************"
echo "* Ubuntu 16.04 is the recommended opearting system for this install.       *"
echo "*                                                                          *"
echo "* This script will install and configure your 401K Coin masternodes.       *"
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

  sudo apt-get install -y ufw
  sudo ufw allow ssh/tcp
  sudo ufw limit ssh/tcp
  sudo ufw logging on
  echo "y" | sudo ufw enable
  sudo ufw status

  mkdir -p ~/bin
  echo 'export PATH=~/bin:$PATH' > ~/.bash_aliases
  source ~/.bashrc
fi

## COMPILE AND INSTALL
wget https://github.com/401KCoin/Script/raw/master/401kcoin-cli
wget https://github.com/401KCoin/Script/raw/master/401kcoin-qt
wget https://github.com/401KCoin/Script/raw/master/401kcoin-tx
wget https://github.com/401KCoin/Script/raw/master/401kcoind
sudo chmod 755 401kcoin*
sudo mv 401kcoin* /usr/bin

CONF_DIR=~/.401kcoin/
mkdir $CONF_DIR
CONF_FILE=401kcoin.conf
PORT=55002

wget https://github.com/401KCoin/Script/raw/master/peers.dat -O $CONF_DIR/peers.dat

IP=$(curl -s4 icanhazip.com)

echo ""
echo "Enter masternode private key for node $ALIAS"
read PRIVKEY

echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
echo "listen=1" >> $CONF_DIR/$CONF_FILE
echo "server=1" >> $CONF_DIR/$CONF_FILE
echo "daemon=1" >> $CONF_DIR/$CONF_FILE
echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
echo "masternode=1" >> $CONF_DIR/$CONF_FILE
echo "" >> $CONF_DIR/$CONF_FILE
echo "" >> $CONF_DIR/$CONF_FILE
echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
echo "masternodeaddr=$IP:$PORT" >> $CONF_DIR/$CONF_FILE
echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE

echo "addnode=167.99.144.178:55002" >> $CONF_DIR/$CONF_FILE
echo "addnode=206.189.171.147:55002" >> $CONF_DIR/$CONF_FILE
echo "addnode=138.197.159.182:55002" >> $CONF_DIR/$CONF_FILE
echo "addnode=178.128.54.249:55002" >> $CONF_DIR/$CONF_FILE
echo "addnode=178.128.1.74:55002" >> $CONF_DIR/$CONF_FILE
echo "addnode=165.227.62.111:55002" >> $CONF_DIR/$CONF_FILE
echo "addnode=139.59.56.40:55002" >> $CONF_DIR/$CONF_FILE
echo "addnode=167.99.64.179:55002" >> $CONF_DIR/$CONF_FILE
echo "addnode=159.65.143.31:55002" >> $CONF_DIR/$CONF_FILE
echo "addnode=188.166.82.245:55002" >> $CONF_DIR/$CONF_FILE

sudo ufw allow $PORT/tcp

401kcoind