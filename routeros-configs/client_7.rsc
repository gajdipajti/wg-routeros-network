/interface wireguard add listen-port=13231 mtu=1420 name=wg-workshop private-key="gCdHDYxb6SXo98AtLsfeZ4qa4S4daUUXbjXt5L9CPXI="
/interface bridge add name=bridge-eoip
/interface eoip add name=eoip-workshot remote-address=10.20.1.1 tunnel-id=7
/ip pool add name=local_7 ranges=10.10.7.2-10.10.7.14
/ip dhcp-server add address-pool=local_7 interface=bridge name=dhcp_7
/routing table add disabled=no fib name=wg
/interface list add name=VPN
/interface bridge port add bridge=bridge-workshop interface=eoip-workshop
/interface list member add interface=wg-workshop list=VPN
/ip address add address=10.20.1.7/24 interface=wg-workshop network=10.20.1.0
/ip address add address=10.10.7.1/28 interface=bridge network=10.10.7.0
/ip dhcp-server network add address=10.10.7.0/28 dns-server=10.20.1.1 gateway=10.10.7.1
/ip firewall mangle add action=mark-routing chain=prerouting new-routing-mark=wg disabled=yes comment="route every traffic into the tunnel" passthrough=yes src-address=10.10.7.0/28
/ip firewall address-list add address=10.10.7.0/28 list=LOCAL7
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=10.20.1.1 pref-src="" routing-table=wg scope=30 suppress-hw-offload=no target-scope=10
/system ntp client set enabled=yes
/system clock set time-zone-name=Europe/Budapest
/system identity set name="WG_ID 7"
/interface wireguard peers add allowed-address=10.20.1.1/32,10.10.1.0/28,10.10.0.0/16 endpoint-address=192.168.100.100 endpoint-port=13231 comment="WID 1" interface=wg-workshop persistent-keepalive=1m public-key="IXzWoBGw4BotvS3uVBIcljCxpU9pM/HTuSAw6VJdsX0="
/ip route add disabled=no distance=1 dst-address=10.10.1.0/28 gateway=10.20.1.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
