/interface wireguard add listen-port=13231 mtu=1420 name=wg-workshop private-key="GHS07rawupTkEMNYK8mt6HlJ70iWJMMm+URNIE3L5lE="
/interface list add name=VPN
/interface list member add interface=wg-workshop list=VPN
/ip address add address=10.20.1.1/24 interface=wg-workshop network=10.20.1.0
/ip firewall mangle add action=change-mss chain=forward new-mss=1300 out-interface=ether1 protocol=tcp tcp-flags=syn tcp-mss=1301-65535
/system ntp client set enabled=yes
/system clock set time-zone-name=Europe/Budapest
/system identity set name="WG_ID 1"
/interface wireguard peers add allowed-address=10.20.1.2/32,10.10.2.0/28 comment="WID 2" interface=wg-workshop persistent-keepalive=1m public-key="8AJrRkMBvozXDsT+IFNBUlJ5ky8/qP5jms16SbKKi2Y="
/ip route add disabled=no distance=1 dst-address=10.10.2.0/28 gateway=10.20.1.2 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-2 remote-address=10.20.1.2 tunnel-id=2
/interface bridge port add bridge=bridge-workshop interface=eoip-2/interface wireguard peers add allowed-address=10.20.1.3/32,10.10.3.0/28 comment="WID 3" interface=wg-workshop persistent-keepalive=1m public-key="u0L6mVnJEFMK2xHvQkBoC3Gy3KUttNf1BXOPIvRzPSQ="
/ip route add disabled=no distance=1 dst-address=10.10.3.0/28 gateway=10.20.1.3 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-3 remote-address=10.20.1.3 tunnel-id=3
/interface bridge port add bridge=bridge-workshop interface=eoip-3/interface wireguard peers add allowed-address=10.20.1.4/32,10.10.4.0/28 comment="WID 4" interface=wg-workshop persistent-keepalive=1m public-key="H9bGFPg8pIdj5OXbB780AKigxfhDLnGjsvkeN7NV91A="
/ip route add disabled=no distance=1 dst-address=10.10.4.0/28 gateway=10.20.1.4 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-4 remote-address=10.20.1.4 tunnel-id=4
/interface bridge port add bridge=bridge-workshop interface=eoip-4/interface wireguard peers add allowed-address=10.20.1.5/32,10.10.5.0/28 comment="WID 5" interface=wg-workshop persistent-keepalive=1m public-key="0D3uJCzumYzyKQ/cxQsQUKLzMw9muK+cxVMT5bKg4So="
/ip route add disabled=no distance=1 dst-address=10.10.5.0/28 gateway=10.20.1.5 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-5 remote-address=10.20.1.5 tunnel-id=5
/interface bridge port add bridge=bridge-workshop interface=eoip-5/interface wireguard peers add allowed-address=10.20.1.6/32,10.10.6.0/28 comment="WID 6" interface=wg-workshop persistent-keepalive=1m public-key="85sdq/7OtmwhDjm/4vGtNpdVv7zG3qJBVWQn7aVShgE="
/ip route add disabled=no distance=1 dst-address=10.10.6.0/28 gateway=10.20.1.6 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-6 remote-address=10.20.1.6 tunnel-id=6
/interface bridge port add bridge=bridge-workshop interface=eoip-6/interface wireguard peers add allowed-address=10.20.1.7/32,10.10.7.0/28 comment="WID 7" interface=wg-workshop persistent-keepalive=1m public-key="BNL4B8tAYEVKWmjkt9K51iOCNOT0QuCxOc4g1XVl/QA="
/ip route add disabled=no distance=1 dst-address=10.10.7.0/28 gateway=10.20.1.7 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-7 remote-address=10.20.1.7 tunnel-id=7
/interface bridge port add bridge=bridge-workshop interface=eoip-7/interface wireguard peers add allowed-address=10.20.1.8/32,10.10.8.0/28 comment="WID 8" interface=wg-workshop persistent-keepalive=1m public-key="Q5mtvAVT1dO1fMXJ62kwxPkAD6j49+jxWpik1v/xUVY="
/ip route add disabled=no distance=1 dst-address=10.10.8.0/28 gateway=10.20.1.8 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-8 remote-address=10.20.1.8 tunnel-id=8
/interface bridge port add bridge=bridge-workshop interface=eoip-8/interface wireguard peers add allowed-address=10.20.1.9/32,10.10.9.0/28 comment="WID 9" interface=wg-workshop persistent-keepalive=1m public-key="ySSBmSV/1NwiiHmSZbmG8nMDW/z0K7akyV9OfPq2vgw="
/ip route add disabled=no distance=1 dst-address=10.10.9.0/28 gateway=10.20.1.9 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-9 remote-address=10.20.1.9 tunnel-id=9
/interface bridge port add bridge=bridge-workshop interface=eoip-9/interface wireguard peers add allowed-address=10.20.1.10/32,10.10.10.0/28 comment="WID 10" interface=wg-workshop persistent-keepalive=1m public-key="q1m3qWBKS5t4xL5/CmVZNahaDZKh/2JytuVYJEDjYk8="
/ip route add disabled=no distance=1 dst-address=10.10.10.0/28 gateway=10.20.1.10 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-10 remote-address=10.20.1.10 tunnel-id=10
/interface bridge port add bridge=bridge-workshop interface=eoip-10/interface wireguard peers add allowed-address=10.20.1.11/32,10.10.11.0/28 comment="WID 11" interface=wg-workshop persistent-keepalive=1m public-key="im3gXOpg7bx7qfYA9JWG/LRXUZ5m9XRYUrda93xFDzY="
/ip route add disabled=no distance=1 dst-address=10.10.11.0/28 gateway=10.20.1.11 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-11 remote-address=10.20.1.11 tunnel-id=11
/interface bridge port add bridge=bridge-workshop interface=eoip-11/interface wireguard peers add allowed-address=10.20.1.12/32,10.10.12.0/28 comment="WID 12" interface=wg-workshop persistent-keepalive=1m public-key="n+vC9q1yqqdV0moE/qINHVWhDgnQJP9pKvQSgVMKaCE="
/ip route add disabled=no distance=1 dst-address=10.10.12.0/28 gateway=10.20.1.12 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-12 remote-address=10.20.1.12 tunnel-id=12
/interface bridge port add bridge=bridge-workshop interface=eoip-12/interface wireguard peers add allowed-address=10.20.1.13/32,10.10.13.0/28 comment="WID 13" interface=wg-workshop persistent-keepalive=1m public-key="qQUQ/sfgFTZUz5+ej/LlqFNyOHbn7TeLHBT+jLgIHgY="
/ip route add disabled=no distance=1 dst-address=10.10.13.0/28 gateway=10.20.1.13 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-13 remote-address=10.20.1.13 tunnel-id=13
/interface bridge port add bridge=bridge-workshop interface=eoip-13/interface wireguard peers add allowed-address=10.20.1.14/32,10.10.14.0/28 comment="WID 14" interface=wg-workshop persistent-keepalive=1m public-key="ACTwGIjNJH6MMUXj9SNggGUli5y6ZNoQVP0Gnt3Uw1c="
/ip route add disabled=no distance=1 dst-address=10.10.14.0/28 gateway=10.20.1.14 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-14 remote-address=10.20.1.14 tunnel-id=14
/interface bridge port add bridge=bridge-workshop interface=eoip-14/interface wireguard peers add allowed-address=10.20.1.15/32,10.10.15.0/28 comment="WID 15" interface=wg-workshop persistent-keepalive=1m public-key="Cq81Qd3TiXJmex1Y+u5U24QO+b3ameDaCkmqO6xttkQ="
/ip route add disabled=no distance=1 dst-address=10.10.15.0/28 gateway=10.20.1.15 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-15 remote-address=10.20.1.15 tunnel-id=15
/interface bridge port add bridge=bridge-workshop interface=eoip-15/interface wireguard peers add allowed-address=10.20.1.16/32,10.10.16.0/28 comment="WID 16" interface=wg-workshop persistent-keepalive=1m public-key="gWXHaba93wWNOdX41r6hFd4r6wtquZPf6MOYT7mh+Bk="
/ip route add disabled=no distance=1 dst-address=10.10.16.0/28 gateway=10.20.1.16 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-16 remote-address=10.20.1.16 tunnel-id=16
/interface bridge port add bridge=bridge-workshop interface=eoip-16/interface wireguard peers add allowed-address=10.20.1.17/32,10.10.17.0/28 comment="WID 17" interface=wg-workshop persistent-keepalive=1m public-key="DdqikFFLxEKUOD4aKbaSjWdGw+w9Q2stU5J75Za8XUY="
/ip route add disabled=no distance=1 dst-address=10.10.17.0/28 gateway=10.20.1.17 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-17 remote-address=10.20.1.17 tunnel-id=17
/interface bridge port add bridge=bridge-workshop interface=eoip-17/interface wireguard peers add allowed-address=10.20.1.18/32,10.10.18.0/28 comment="WID 18" interface=wg-workshop persistent-keepalive=1m public-key="tS9sQPhNq/u3b1KoW/kwn84e1RsFWxcQzReVYWHTVEI="
/ip route add disabled=no distance=1 dst-address=10.10.18.0/28 gateway=10.20.1.18 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-18 remote-address=10.20.1.18 tunnel-id=18
/interface bridge port add bridge=bridge-workshop interface=eoip-18/interface wireguard peers add allowed-address=10.20.1.19/32,10.10.19.0/28 comment="WID 19" interface=wg-workshop persistent-keepalive=1m public-key="CzMKT0gaIwDQ26w6b2Hzx4vV0yXMoq2/7Vn0k+pxI0w="
/ip route add disabled=no distance=1 dst-address=10.10.19.0/28 gateway=10.20.1.19 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-19 remote-address=10.20.1.19 tunnel-id=19
/interface bridge port add bridge=bridge-workshop interface=eoip-19/interface wireguard peers add allowed-address=10.20.1.20/32,10.10.20.0/28 comment="WID 20" interface=wg-workshop persistent-keepalive=1m public-key="w2gMfC2ghE47zUv6jcIFFxic648896CSU8Cu4So2Pyo="
/ip route add disabled=no distance=1 dst-address=10.10.20.0/28 gateway=10.20.1.20 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-20 remote-address=10.20.1.20 tunnel-id=20
/interface bridge port add bridge=bridge-workshop interface=eoip-20