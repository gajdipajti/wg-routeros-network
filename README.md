# wg-routeros-network

Tools for generating a Wireguard network for Mikrotik RouterOS and possibly other peers later. This should be the ideal home office setup.

Currently implemented functions in the wg-gen.pl Perl script:

* Generate a table.csv with all the keys pairs, tunnel ip addresses and LAN networks.
* Generate server and client configuration, which include:
  * Wireguard interface and peer configuration in a 1 server - N peer network.
  * EoIP tunnels to the server with a bridge configuration on the clients (no physical interface is added).
  * Set up static routes to reach each peer's LAN subnet.
  * We only NAT at the wireguard tunnel endpoints WAN interface.
  * Implement the routing of 0.0.0.0/0 into the tunnel using routing-mark and a new routing table. To disable this, just disable the mangle firewall rule.
  * Set ntp and timezone.

Missing functionality:

* change static routes to OSPFv2.
* configure the peer's wireless interface with CAPsMAN.
* generate configuration files for Linux, Windows, Android, iOS.
* generate the QR code for mobile clients.

## Perl script

```bash
./wg-gen.pl 21
```

To generate QR Code in the Perl script (not yet implemented), install the following ubuntu package:
```libimager-qrcode-perl```

## Old table generation

A simple table can be generated using the following bash script:

```bash
for idx in $(seq 1 20)
do 
  echo "$idx; 10.0.0.$idx; $(wg genkey | xargs bash -c 'echo -n $@; echo -n \;\ ; echo $@ | wg pubkey' bash)";
done
```