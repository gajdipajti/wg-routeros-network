/interface wireguard add listen-port=13231 mtu=1420 name=wg-workshop private-key="kPmvC1eKPcttKUofRUVanmDbOFUWyQxY1SYcDuRukXw="
/interface list add name=VPN
/interface list member add interface=wg-workshop list=VPN
/ip address add address=10.20.1.4/24 interface=wg-workshop network=10.20.1.0
/ip firewall mangle add action=change-mss chain=forward new-mss=1300 out-interface=ether1 protocol=tcp tcp-flags=syn tcp-mss=1301-65535
/system ntp client set enabled=yes
/system clock set time-zone-name=Europe/Budapest
/system identity set name="WG_ID 4"
/interface wireguard peers add allowed-address=10.20.1.1/32,10.10.1.0/28,10.10.0.0/16 endpoint-address=192.168.100.100 comment="WID 1" interface=wg-workshop persistent-keepalive=1m public-key="GFGKfV8OgqhtnJ9+KAZhsyuzpYaQsmOe3BeT3jfrD3c="
/ip route add disabled=no distance=1 dst-address=10.10.1.0/28 gateway=10.20.1.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
