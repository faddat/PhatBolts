# PhatBolts
Lightning node launcher designed to be run as root on a fresh VPS or bare metal server, and accessed via Zap

PhatBolts is really just a bash script that automates the installation of bitcoind and LND in /usr/bin and some systemd units that run bitcoind and LND in a fairly opinionated way that I know to work well for a remote-access scenario.  The script is extremely easy to audit, and is written in the simplest possible bash, with ample comments.  

The script provides some niceties like allowing the user to enter their external IP address and automatically putting that into the systemd units where it's needed.  

## Some ways NOT to use PhatBolts:
* On a multi-purpose machine.  Phat Bolts is designed to be run on dedicated VMs/Hardware, only.  
* On a machine that doesn't have a public IP address.  PhatBolts is designed for machines with public IPs or owners who know how to forward ports on their router.  Please assume that there's no support for NAT.  (Well, there is, but this isn't the setup for that.)

^^TL;DR:  PhatBolts is for a very specific context.  You've got a blank machine and you want to make it into a lightning node.


## How TO use PhatBolts:
bash <(curl -s https://raw.githubusercontent.com/faddat/PhatBolts/master/install.sh)

Yes, it's basically that easy.  For now, the user is responsible for picking up the files:

* /root/.lnd/data/chain/bitcoin/mainnet/admin.macaroon
* /root/.lnd/tls.cert

-- after the install is complete, feel free to check on the status of LND with `systemctl status lnd`.  Then, you should see it asking you to run `lncli create`.  Youl'll then preserve your 24 words very carefully, and choose a password to encrypt your wallet.  Finally, you'll want to run `lncli unlock` and enter your password.  Then, LND will begin running.  To verify that, you can use `systemctl status lnd`.  

## Security

At this point I haven't tested the security of this setup to any appreciable degree.  As I do that, or others make recommendations, I'll be putting that information here and adjusting the code as needed.  

# PB is a one-trick pony.  If you ask it to do tricks other than turning a VPS or bare-metal server into a lightning node super-easily, you are going to be disappointed.  Please don't.  

