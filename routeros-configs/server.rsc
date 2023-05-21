/interface wireguard add listen-port=13231 mtu=1420 name=wg-workshop private-key="8Ff0CnPFNcXvqqKs7i7GtgyDUg7mFojIyUCKqEIh8no="
/interface list add name=VPN
/interface list member add interface=wg-workshop list=VPN
/ip address add address=10.20.1.1/24 interface=wg-workshop network=10.20.1.0
/ip firewall mangle add action=change-mss chain=forward new-mss=1300 out-interface=ether1 protocol=tcp tcp-flags=syn tcp-mss=1301-65535
/system ntp client set enabled=yes
/system clock set time-zone-name=Europe/Budapest
/system identity set name="WG_ID 1"
/interface wireguard peers add allowed-address=10.20.1.2/32,10.10.2.0/28 comment="WID 2" interface=wg-workshop persistent-keepalive=1m public-key="Vv2wyFRdJv7F0pVi00knUbvTZzIgz5e9BZjerJjVYV4="
/ip route add disabled=no distance=1 dst-address=10.10.2.0/28 gateway=10.20.1.2 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-2 remote-address=10.20.1.2 tunnel-id=2
/interface bridge port add bridge=bridge-workshop interface=eoip-2/interface wireguard peers add allowed-address=10.20.1.3/32,10.10.3.0/28 comment="WID 3" interface=wg-workshop persistent-keepalive=1m public-key="/ANN+VReijYUJwI3OnR6iFMGhgIB/aJmntFe7iPhDmk="
/ip route add disabled=no distance=1 dst-address=10.10.3.0/28 gateway=10.20.1.3 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-3 remote-address=10.20.1.3 tunnel-id=3
/interface bridge port add bridge=bridge-workshop interface=eoip-3/interface wireguard peers add allowed-address=10.20.1.4/32,10.10.4.0/28 comment="WID 4" interface=wg-workshop persistent-keepalive=1m public-key="qaw3VW8D5QTmgKzjUYuSIPQC+iSVwL1KghyA/E2tiSc="
/ip route add disabled=no distance=1 dst-address=10.10.4.0/28 gateway=10.20.1.4 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-4 remote-address=10.20.1.4 tunnel-id=4
/interface bridge port add bridge=bridge-workshop interface=eoip-4/interface wireguard peers add allowed-address=10.20.1.5/32,10.10.5.0/28 comment="WID 5" interface=wg-workshop persistent-keepalive=1m public-key="MpWRRWGE9PysgaA0xpy3kb+lOyxm+jwFmSkFr8edUxg="
/ip route add disabled=no distance=1 dst-address=10.10.5.0/28 gateway=10.20.1.5 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-5 remote-address=10.20.1.5 tunnel-id=5
/interface bridge port add bridge=bridge-workshop interface=eoip-5/interface wireguard peers add allowed-address=10.20.1.6/32,10.10.6.0/28 comment="WID 6" interface=wg-workshop persistent-keepalive=1m public-key="udwi9HMf3NEEQRXqKMwnORhNawLpT6jIjLGLElCDkz0="
/ip route add disabled=no distance=1 dst-address=10.10.6.0/28 gateway=10.20.1.6 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-6 remote-address=10.20.1.6 tunnel-id=6
/interface bridge port add bridge=bridge-workshop interface=eoip-6/interface wireguard peers add allowed-address=10.20.1.7/32,10.10.7.0/28 comment="WID 7" interface=wg-workshop persistent-keepalive=1m public-key="oJ9iMTmH2sGACh5jeyzCTcYls/uApQkFb/5qDNCT8hI="
/ip route add disabled=no distance=1 dst-address=10.10.7.0/28 gateway=10.20.1.7 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-7 remote-address=10.20.1.7 tunnel-id=7
/interface bridge port add bridge=bridge-workshop interface=eoip-7/interface wireguard peers add allowed-address=10.20.1.8/32,10.10.8.0/28 comment="WID 8" interface=wg-workshop persistent-keepalive=1m public-key="QKA+2mlYaxOeCYQb7qNBkXJTW/B8r7dWzz0ix8Zj+UM="
/ip route add disabled=no distance=1 dst-address=10.10.8.0/28 gateway=10.20.1.8 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-8 remote-address=10.20.1.8 tunnel-id=8
/interface bridge port add bridge=bridge-workshop interface=eoip-8/interface wireguard peers add allowed-address=10.20.1.9/32,10.10.9.0/28 comment="WID 9" interface=wg-workshop persistent-keepalive=1m public-key="AUhMKey8QgVmo/hmC4IPm93+te0OOI9t/f1xpOLQTHw="
/ip route add disabled=no distance=1 dst-address=10.10.9.0/28 gateway=10.20.1.9 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-9 remote-address=10.20.1.9 tunnel-id=9
/interface bridge port add bridge=bridge-workshop interface=eoip-9/interface wireguard peers add allowed-address=10.20.1.10/32,10.10.10.0/28 comment="WID 10" interface=wg-workshop persistent-keepalive=1m public-key="Fq35s+oFY+Dnf6Yu2mFEdXdNjp5609z4kwIu8I9M0A0="
/ip route add disabled=no distance=1 dst-address=10.10.10.0/28 gateway=10.20.1.10 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-10 remote-address=10.20.1.10 tunnel-id=10
/interface bridge port add bridge=bridge-workshop interface=eoip-10/interface wireguard peers add allowed-address=10.20.1.11/32,10.10.11.0/28 comment="WID 11" interface=wg-workshop persistent-keepalive=1m public-key="8GgE0rRSwb3qHUOPocc8eVdemf2BSEdEB7Y4Smls7As="
/ip route add disabled=no distance=1 dst-address=10.10.11.0/28 gateway=10.20.1.11 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-11 remote-address=10.20.1.11 tunnel-id=11
/interface bridge port add bridge=bridge-workshop interface=eoip-11/interface wireguard peers add allowed-address=10.20.1.12/32,10.10.12.0/28 comment="WID 12" interface=wg-workshop persistent-keepalive=1m public-key="lk19KVJSWixKorp7l0py+pRkFHSlg14cxENszLDTwxo="
/ip route add disabled=no distance=1 dst-address=10.10.12.0/28 gateway=10.20.1.12 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-12 remote-address=10.20.1.12 tunnel-id=12
/interface bridge port add bridge=bridge-workshop interface=eoip-12/interface wireguard peers add allowed-address=10.20.1.13/32,10.10.13.0/28 comment="WID 13" interface=wg-workshop persistent-keepalive=1m public-key="e2rAlnXimCytCx/wuhfaiFWlW7ml1XuL5TuObNF6ogU="
/ip route add disabled=no distance=1 dst-address=10.10.13.0/28 gateway=10.20.1.13 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-13 remote-address=10.20.1.13 tunnel-id=13
/interface bridge port add bridge=bridge-workshop interface=eoip-13/interface wireguard peers add allowed-address=10.20.1.14/32,10.10.14.0/28 comment="WID 14" interface=wg-workshop persistent-keepalive=1m public-key="BMpAPbF1cDQ6enat2hh6QGXuNgDhpQe/ZKV+/QKEXyA="
/ip route add disabled=no distance=1 dst-address=10.10.14.0/28 gateway=10.20.1.14 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-14 remote-address=10.20.1.14 tunnel-id=14
/interface bridge port add bridge=bridge-workshop interface=eoip-14/interface wireguard peers add allowed-address=10.20.1.15/32,10.10.15.0/28 comment="WID 15" interface=wg-workshop persistent-keepalive=1m public-key="SkvbWU5w+eWpPiSHqvH9A5gZ3NSCDhuxtoNKEcHCtHY="
/ip route add disabled=no distance=1 dst-address=10.10.15.0/28 gateway=10.20.1.15 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-15 remote-address=10.20.1.15 tunnel-id=15
/interface bridge port add bridge=bridge-workshop interface=eoip-15/interface wireguard peers add allowed-address=10.20.1.16/32,10.10.16.0/28 comment="WID 16" interface=wg-workshop persistent-keepalive=1m public-key="A5VWdIDb37LPPrx69j1Wv7rJAE9C7XQmegALncVtz04="
/ip route add disabled=no distance=1 dst-address=10.10.16.0/28 gateway=10.20.1.16 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-16 remote-address=10.20.1.16 tunnel-id=16
/interface bridge port add bridge=bridge-workshop interface=eoip-16/interface wireguard peers add allowed-address=10.20.1.17/32,10.10.17.0/28 comment="WID 17" interface=wg-workshop persistent-keepalive=1m public-key="oN/FjMzSBLldwyImIGldInvuyklYrlOnTvnKGvUpS1o="
/ip route add disabled=no distance=1 dst-address=10.10.17.0/28 gateway=10.20.1.17 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-17 remote-address=10.20.1.17 tunnel-id=17
/interface bridge port add bridge=bridge-workshop interface=eoip-17/interface wireguard peers add allowed-address=10.20.1.18/32,10.10.18.0/28 comment="WID 18" interface=wg-workshop persistent-keepalive=1m public-key="ac0A/0vDw0fhE5COPcCkf3HZyCfVec13j/59cAwdwyM="
/ip route add disabled=no distance=1 dst-address=10.10.18.0/28 gateway=10.20.1.18 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-18 remote-address=10.20.1.18 tunnel-id=18
/interface bridge port add bridge=bridge-workshop interface=eoip-18/interface wireguard peers add allowed-address=10.20.1.19/32,10.10.19.0/28 comment="WID 19" interface=wg-workshop persistent-keepalive=1m public-key="byDxOpSvzLDKBULvOvEN3B+4NunaX/RMTkRZczhREFg="
/ip route add disabled=no distance=1 dst-address=10.10.19.0/28 gateway=10.20.1.19 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-19 remote-address=10.20.1.19 tunnel-id=19
/interface bridge port add bridge=bridge-workshop interface=eoip-19/interface wireguard peers add allowed-address=10.20.1.20/32,10.10.20.0/28 comment="WID 20" interface=wg-workshop persistent-keepalive=1m public-key="fMST6h32s4+5rEedUBbbxmUnkt6m/E8tLx+de3O9uTs="
/ip route add disabled=no distance=1 dst-address=10.10.20.0/28 gateway=10.20.1.20 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface eoip add name=eoip-20 remote-address=10.20.1.20 tunnel-id=20
/interface bridge port add bridge=bridge-workshop interface=eoip-20