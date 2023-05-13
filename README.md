# wg-routeros-network
Tools for generating a Wireguard network for Mikrotik RouterOS

```bash
for idx in $(seq 1 30)
do 
  echo "$idx; 10.10.10.$idx; $(wg genkey | xargs bash -c 'echo -n $@; echo -n \;\ ; echo $@ | wg pubkey' bash)";
done
```
