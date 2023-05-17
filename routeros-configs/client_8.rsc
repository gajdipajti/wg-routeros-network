/interface wireguard add listen-port=13231 mtu=1420 name=wg-workshop private-key="mFHdIKnAW9zeBE7/Iqc3mHAkM0KHTvZoX0IL3M0iMVE="
/interface list add name=VPN
/interface list member add interface=wg-workshop list=VPN
/ip address add address=10.20.1.8/24 interface=wg-workshop network=10.20.1.0
/ip firewall nat add action=masquerade chain=srcnat out-interface-list=VPN
/system ntp client set enabled=yes
/system clock set time-zone-name=Europe/Budapest
/system identity set name="WG_ID 8"
/interface wireguard peers add allowed-address=10.20.1.1/32,10.10.1.0/28,10.10.0.0/16 endpoint-address=192.168.100.100 comment="WID 1" interface=wg-workshop persistent-keepalive=1m public-key="WEpgV4veDgcm73Q7MZvI5Fc09RwW8KXtdTN43RfpYlU="
/ip route add disabled=no distance=1 dst-address=10.10.1.0/28 gateway=10.20.1.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
