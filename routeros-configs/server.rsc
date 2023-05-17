/interface wireguard add listen-port=13231 mtu=1420 name=wg-workshop private-key="aOc3bX6NaAoJDdCDOQFnlTqJYXOUWphf5j8eH4QziEw="
/interface list add name=VPN
/interface list member add interface=wg-workshop list=VPN
/ip address add address=10.20.1.1/24 interface=wg-workshop network=10.20.1.0
/ip firewall mangle add action=change-mss chain=forward new-mss=1300 out-interface=ether1 protocol=tcp tcp-flags=syn tcp-mss=1301-65535
/system ntp client set enabled=yes
/system clock set time-zone-name=Europe/Budapest
/system identity set name="WG_ID 1"
/interface wireguard peers add allowed-address=10.20.1.2/32,10.10.2.0/28 comment="WID 2" interface=wg-workshop persistent-keepalive=1m public-key="F5NJ3LUTYkLNvxB7RLTSg0p0K5bmJ/KRwfcST+erSEs="
/ip route add disabled=no distance=1 dst-address=10.10.2.0/28 gateway=10.20.1.2 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.3/32,10.10.3.0/28 comment="WID 3" interface=wg-workshop persistent-keepalive=1m public-key="8qXEEeD7PDQUyD6CUKBIN8pj+e8Slg5+O7zW54Q24xU="
/ip route add disabled=no distance=1 dst-address=10.10.3.0/28 gateway=10.20.1.3 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.4/32,10.10.4.0/28 comment="WID 4" interface=wg-workshop persistent-keepalive=1m public-key="l1LQPDsLPoLvhVI3wJ5RMsFrumjIeXfcFXMjr0FffQk="
/ip route add disabled=no distance=1 dst-address=10.10.4.0/28 gateway=10.20.1.4 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.5/32,10.10.5.0/28 comment="WID 5" interface=wg-workshop persistent-keepalive=1m public-key="VJVK0cmuYSFk34uyhyu5CDVacLTcbOsq4NpY3z2cf1E="
/ip route add disabled=no distance=1 dst-address=10.10.5.0/28 gateway=10.20.1.5 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.6/32,10.10.6.0/28 comment="WID 6" interface=wg-workshop persistent-keepalive=1m public-key="FnxFbNkfKJgr4n41SQRzFgvaC9rsqANa0jFDyXqkFgo="
/ip route add disabled=no distance=1 dst-address=10.10.6.0/28 gateway=10.20.1.6 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.7/32,10.10.7.0/28 comment="WID 7" interface=wg-workshop persistent-keepalive=1m public-key="5eSXzGf7jyNk922Wkx4YtnKegcdzK4ExwNbVaBh4QAY="
/ip route add disabled=no distance=1 dst-address=10.10.7.0/28 gateway=10.20.1.7 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.8/32,10.10.8.0/28 comment="WID 8" interface=wg-workshop persistent-keepalive=1m public-key="nYslmICn5MXmkT/zwGON+1wolJ+q/yTlm5CfkIyDxUI="
/ip route add disabled=no distance=1 dst-address=10.10.8.0/28 gateway=10.20.1.8 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.9/32,10.10.9.0/28 comment="WID 9" interface=wg-workshop persistent-keepalive=1m public-key="grjFGv6Fc/iTY4Z+qtP+IstOB0/vCN5jLYKXtKrXKyA="
/ip route add disabled=no distance=1 dst-address=10.10.9.0/28 gateway=10.20.1.9 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.10/32,10.10.10.0/28 comment="WID 10" interface=wg-workshop persistent-keepalive=1m public-key="OhInKgQ4cJH90rjvU95wQjdv/ezGDPH1vkv1Ebp5fAE="
/ip route add disabled=no distance=1 dst-address=10.10.10.0/28 gateway=10.20.1.10 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.11/32,10.10.11.0/28 comment="WID 11" interface=wg-workshop persistent-keepalive=1m public-key="iU7DY3komffRIFZX066XOJCRoc0RqpSBsqr9H1NlbmM="
/ip route add disabled=no distance=1 dst-address=10.10.11.0/28 gateway=10.20.1.11 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.12/32,10.10.12.0/28 comment="WID 12" interface=wg-workshop persistent-keepalive=1m public-key="ofaymFTd8H5LwTMhMGNa7A4fd5TC/pra+vH37S2IZ0I="
/ip route add disabled=no distance=1 dst-address=10.10.12.0/28 gateway=10.20.1.12 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.13/32,10.10.13.0/28 comment="WID 13" interface=wg-workshop persistent-keepalive=1m public-key="IcGEBOozARcpsedPO6D/DSd6rNZwy2A4GDtplmZ6nmg="
/ip route add disabled=no distance=1 dst-address=10.10.13.0/28 gateway=10.20.1.13 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.14/32,10.10.14.0/28 comment="WID 14" interface=wg-workshop persistent-keepalive=1m public-key="mxryNDJZUaAtMWHReCEujtcRcQcc5xz0LvS9dGhK0Xk="
/ip route add disabled=no distance=1 dst-address=10.10.14.0/28 gateway=10.20.1.14 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.15/32,10.10.15.0/28 comment="WID 15" interface=wg-workshop persistent-keepalive=1m public-key="JdobvPkqkhe/46v1s6TYKOElaWu35CkQr27XGeWY2kM="
/ip route add disabled=no distance=1 dst-address=10.10.15.0/28 gateway=10.20.1.15 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.16/32,10.10.16.0/28 comment="WID 16" interface=wg-workshop persistent-keepalive=1m public-key="/i47qTf9RlGebsjdStaDOaebIDuRVQV3BTAniWWmwlk="
/ip route add disabled=no distance=1 dst-address=10.10.16.0/28 gateway=10.20.1.16 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.17/32,10.10.17.0/28 comment="WID 17" interface=wg-workshop persistent-keepalive=1m public-key="yw76ACtV96h7giu3H+EVphJQe/csF8gb3+lbhGuyEkc="
/ip route add disabled=no distance=1 dst-address=10.10.17.0/28 gateway=10.20.1.17 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.18/32,10.10.18.0/28 comment="WID 18" interface=wg-workshop persistent-keepalive=1m public-key="neLK5r69HTXqzJR8ytHts/+ANG3ji4leDACJi8D/rTc="
/ip route add disabled=no distance=1 dst-address=10.10.18.0/28 gateway=10.20.1.18 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.19/32,10.10.19.0/28 comment="WID 19" interface=wg-workshop persistent-keepalive=1m public-key="iVK99Qusy+nHMSFWcZbAk/5W/y66Pa+gV7XrALX5G3M="
/ip route add disabled=no distance=1 dst-address=10.10.19.0/28 gateway=10.20.1.19 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.20/32,10.10.20.0/28 comment="WID 20" interface=wg-workshop persistent-keepalive=1m public-key="UNYyTXeBxkXw3pGLmmaU32Jye8fWoxvMjTluRpd4ckI="
/ip route add disabled=no distance=1 dst-address=10.10.20.0/28 gateway=10.20.1.20 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
