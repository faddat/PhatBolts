# Welcoming the user
echo "Get ready for some PhatBolts!"
echo "Please run this only on Ubuntu 18.10"

echo "Installing PPA support for the bitcoind ppa, and ensuring that system has wget for future commands."
apt install software-properties-common wget

# Asking the user to enter their IP address and taking their input
echo "Please enter your public IP address and press enter when finished."
read ip

echo "Please choose an alias for your node"
read alias

echo "Installing Bitcoind, updating all apt packages, and removing default systemd unit"
add-apt-repository ppa:bitcoin/bitcoin
apt-get update
apt upgrade
apt install bitcoind
rm /etc/systemd/system/multi-user.target.wants/bitcoind.service


echo "Installing LND"
wget https://github.com/lightningnetwork/lnd/releases/download/v0.5.2-beta/lnd-linux-amd64-v0.5.2-beta.tar.gz
tar xvf lnd-linux-amd64-v0.5.2-beta.tar.gz
cp lnd-linux-amd64-v0.5.2-beta/* /usr/bin

echo "Installing unit files"
wget https://github.com/faddat/PhatBolts/raw/master/bitcoind.service -P /etc/systemd/system/
wget https://github.com/faddat/PhatBolts/raw/master/lnd.service -P /etc/systemd/system/
sed -i -e "s/555.555.555.555/$ip/g" /etc/systemd/system/lnd.service
sed -i -e "s/DroneEnergy/$alias/g" /etc/systemd/system/lnd.service

echo "Enabling systemd units and starting services"

systemctl enable bitcoind
systemctl enable lnd
systemctl start bitcoind
sleep 5
systemctl start lnd
