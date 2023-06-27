/interface wireguard add listen-port=13231 mtu=1420 name=wg-workshop private-key="4I1pF5n83cuUWsTMt6V04Oyng3UODmRrvXymZs1b5HM="
/interface list add name=VPN
/interface list member add interface=wg-workshop list=VPN
/ip address add address=10.20.1.1/24 interface=wg-workshop network=10.20.1.0
/ip firewall mangle add action=change-mss chain=forward new-mss=1300 out-interface=ether1 protocol=tcp tcp-flags=syn tcp-mss=1301-65535
/system ntp client set enabled=yes
/system clock set time-zone-name=Europe/Budapest
/system identity set name="WG_ID 1"
/interface wireguard peers add allowed-address=10.20.1.2/32,10.10.2.0/28 comment="WID 2" interface=wg-workshop persistent-keepalive=1m public-key="Kh2oVNwLuqlEWgXfYeoksD7o8jBwrg4h3/W3iGmmkFs="
/ip route add disabled=no distance=1 dst-address=10.10.2.0/28 gateway=10.20.1.2 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-2 remote-address=10.20.1.2 tunnel-id=2
/interface bridge port add bridge=bridge-workshop interface=eoip-2
/interface wireguard peers add allowed-address=10.20.1.3/32,10.10.3.0/28 comment="WID 3" interface=wg-workshop persistent-keepalive=1m public-key="ksU4TReLKl99etsrEAoZMJUE64c2/XEyrFEy+FRu9Q4="
/ip route add disabled=no distance=1 dst-address=10.10.3.0/28 gateway=10.20.1.3 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-3 remote-address=10.20.1.3 tunnel-id=3
/interface bridge port add bridge=bridge-workshop interface=eoip-3
/interface wireguard peers add allowed-address=10.20.1.4/32,10.10.4.0/28 comment="WID 4" interface=wg-workshop persistent-keepalive=1m public-key="6DGuFydYd9vkQhvEYoIdMnwCzLf28gEFQEvi7PMnVi4="
/ip route add disabled=no distance=1 dst-address=10.10.4.0/28 gateway=10.20.1.4 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-4 remote-address=10.20.1.4 tunnel-id=4
/interface bridge port add bridge=bridge-workshop interface=eoip-4
/interface wireguard peers add allowed-address=10.20.1.5/32,10.10.5.0/28 comment="WID 5" interface=wg-workshop persistent-keepalive=1m public-key="6f4vj7mWIO3VqIteXQHOrVhb0jro/S7/elpYmo2g+Ao="
/ip route add disabled=no distance=1 dst-address=10.10.5.0/28 gateway=10.20.1.5 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-5 remote-address=10.20.1.5 tunnel-id=5
/interface bridge port add bridge=bridge-workshop interface=eoip-5
/interface wireguard peers add allowed-address=10.20.1.6/32,10.10.6.0/28 comment="WID 6" interface=wg-workshop persistent-keepalive=1m public-key="UbhxTbeXgKVh1vbOqnA/t07ekg5i3S8dHpm4nZFdtV8="
/ip route add disabled=no distance=1 dst-address=10.10.6.0/28 gateway=10.20.1.6 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-6 remote-address=10.20.1.6 tunnel-id=6
/interface bridge port add bridge=bridge-workshop interface=eoip-6
/interface wireguard peers add allowed-address=10.20.1.7/32,10.10.7.0/28 comment="WID 7" interface=wg-workshop persistent-keepalive=1m public-key="e5H/Eu1wcpYQQDJVsV9S5LqsXpO3lXVUrvvSL8UKzls="
/ip route add disabled=no distance=1 dst-address=10.10.7.0/28 gateway=10.20.1.7 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-7 remote-address=10.20.1.7 tunnel-id=7
/interface bridge port add bridge=bridge-workshop interface=eoip-7
/interface wireguard peers add allowed-address=10.20.1.8/32,10.10.8.0/28 comment="WID 8" interface=wg-workshop persistent-keepalive=1m public-key="gKnheqpHQJ0rZJi7tqwuQ8PRVVVSLLyRScSibinr+3M="
/ip route add disabled=no distance=1 dst-address=10.10.8.0/28 gateway=10.20.1.8 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-8 remote-address=10.20.1.8 tunnel-id=8
/interface bridge port add bridge=bridge-workshop interface=eoip-8
/interface wireguard peers add allowed-address=10.20.1.9/32,10.10.9.0/28 comment="WID 9" interface=wg-workshop persistent-keepalive=1m public-key="fGaIa/OnBCpCXphwxA+8H8kvKv06gTPZBhgH1gPUkxc="
/ip route add disabled=no distance=1 dst-address=10.10.9.0/28 gateway=10.20.1.9 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-9 remote-address=10.20.1.9 tunnel-id=9
/interface bridge port add bridge=bridge-workshop interface=eoip-9
/interface wireguard peers add allowed-address=10.20.1.10/32,10.10.10.0/28 comment="WID 10" interface=wg-workshop persistent-keepalive=1m public-key="WiDaZocz3sjGhFsQCZ+JdWejD3oMfbDl10NJZbno1WM="
/ip route add disabled=no distance=1 dst-address=10.10.10.0/28 gateway=10.20.1.10 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-10 remote-address=10.20.1.10 tunnel-id=10
/interface bridge port add bridge=bridge-workshop interface=eoip-10
/interface wireguard peers add allowed-address=10.20.1.11/32,10.10.11.0/28 comment="WID 11" interface=wg-workshop persistent-keepalive=1m public-key="8yVHNTxFCaGnm278mjr8jI5Dzkv0AzDCandv5swcMQ0="
/ip route add disabled=no distance=1 dst-address=10.10.11.0/28 gateway=10.20.1.11 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-11 remote-address=10.20.1.11 tunnel-id=11
/interface bridge port add bridge=bridge-workshop interface=eoip-11
/interface wireguard peers add allowed-address=10.20.1.12/32,10.10.12.0/28 comment="WID 12" interface=wg-workshop persistent-keepalive=1m public-key="8HTFlJBh5nxVrvDsW/wlUt6qSsLgmuKI/S+rXAx5fwc="
/ip route add disabled=no distance=1 dst-address=10.10.12.0/28 gateway=10.20.1.12 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-12 remote-address=10.20.1.12 tunnel-id=12
/interface bridge port add bridge=bridge-workshop interface=eoip-12
/interface wireguard peers add allowed-address=10.20.1.13/32,10.10.13.0/28 comment="WID 13" interface=wg-workshop persistent-keepalive=1m public-key="TOqPrGxAK7MEQdY3279+Fi+qTSYZUZiJuQP/NmT5rWs="
/ip route add disabled=no distance=1 dst-address=10.10.13.0/28 gateway=10.20.1.13 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-13 remote-address=10.20.1.13 tunnel-id=13
/interface bridge port add bridge=bridge-workshop interface=eoip-13
/interface wireguard peers add allowed-address=10.20.1.14/32,10.10.14.0/28 comment="WID 14" interface=wg-workshop persistent-keepalive=1m public-key="92CSG2unCHmU0fynOisNsA38A5vJPtp8n2bWDhsQzS0="
/ip route add disabled=no distance=1 dst-address=10.10.14.0/28 gateway=10.20.1.14 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-14 remote-address=10.20.1.14 tunnel-id=14
/interface bridge port add bridge=bridge-workshop interface=eoip-14
/interface wireguard peers add allowed-address=10.20.1.15/32,10.10.15.0/28 comment="WID 15" interface=wg-workshop persistent-keepalive=1m public-key="wHVOuPQS22zR+qBgL1FwfqvtOq7sLZZIcQ3jZEVPdlA="
/ip route add disabled=no distance=1 dst-address=10.10.15.0/28 gateway=10.20.1.15 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-15 remote-address=10.20.1.15 tunnel-id=15
/interface bridge port add bridge=bridge-workshop interface=eoip-15
/interface wireguard peers add allowed-address=10.20.1.16/32,10.10.16.0/28 comment="WID 16" interface=wg-workshop persistent-keepalive=1m public-key="/AZiIr03NCw7qoOM/fTII1N6zwCzr5ZNrpp6/Hl7c20="
/ip route add disabled=no distance=1 dst-address=10.10.16.0/28 gateway=10.20.1.16 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-16 remote-address=10.20.1.16 tunnel-id=16
/interface bridge port add bridge=bridge-workshop interface=eoip-16
/interface wireguard peers add allowed-address=10.20.1.17/32,10.10.17.0/28 comment="WID 17" interface=wg-workshop persistent-keepalive=1m public-key="eA6R0vbNfp2kPNmD4lrxvPAPP2HralquTkwJdL6GyhE="
/ip route add disabled=no distance=1 dst-address=10.10.17.0/28 gateway=10.20.1.17 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-17 remote-address=10.20.1.17 tunnel-id=17
/interface bridge port add bridge=bridge-workshop interface=eoip-17
/interface wireguard peers add allowed-address=10.20.1.18/32,10.10.18.0/28 comment="WID 18" interface=wg-workshop persistent-keepalive=1m public-key="gmGDdT5DQv+2sivZl1LZf0hvmU2PqbDnKVoq9B6exV8="
/ip route add disabled=no distance=1 dst-address=10.10.18.0/28 gateway=10.20.1.18 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-18 remote-address=10.20.1.18 tunnel-id=18
/interface bridge port add bridge=bridge-workshop interface=eoip-18
/interface wireguard peers add allowed-address=10.20.1.19/32,10.10.19.0/28 comment="WID 19" interface=wg-workshop persistent-keepalive=1m public-key="39CHYz6u8unVoX7bfLT9xL6185nRd/bY1v1qeY1RohM="
/ip route add disabled=no distance=1 dst-address=10.10.19.0/28 gateway=10.20.1.19 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-19 remote-address=10.20.1.19 tunnel-id=19
/interface bridge port add bridge=bridge-workshop interface=eoip-19
/interface wireguard peers add allowed-address=10.20.1.20/32,10.10.20.0/28 comment="WID 20" interface=wg-workshop persistent-keepalive=1m public-key="vV8t3ckvYsy9Wy4C44IQ4GShVOyTUw/S+XhXcDg9Rwc="
/ip route add disabled=no distance=1 dst-address=10.10.20.0/28 gateway=10.20.1.20 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-20 remote-address=10.20.1.20 tunnel-id=20
/interface bridge port add bridge=bridge-workshop interface=eoip-20
