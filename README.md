# wg-routeros-network

Tools for generating a Wireguard network for Mikrotik RouterOS.

A simple table can be generated using the following bash script:

```bash
for idx in $(seq 1 30)
do 
  echo "$idx; 10.0.0.$idx; $(wg genkey | xargs bash -c 'echo -n $@; echo -n \;\ ; echo $@ | wg pubkey' bash)";
done
```

## Perl script

```bash
./wg-gen.pl 100
```

To generate QR Code in the Perl script, install the following ubuntu package:
```libimager-qrcode-perl```
