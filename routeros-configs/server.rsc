/interface wireguard add listen-port=13231 mtu=1420 name=wg-workshop private-key="iKB2gjSFhe4nZDeDmo672YRebANMoe+Et+gv8Omh6WE="
/interface list add name=VPN
/interface list member add interface=wg-workshop list=VPN
/ip address add address=10.20.1.1/24 interface=wg-workshop network=10.20.1.0
/ip firewall mangle add action=change-mss chain=forward new-mss=1300 out-interface=ether1 protocol=tcp tcp-flags=syn tcp-mss=1301-65535
/system ntp client set enabled=yes
/system clock set time-zone-name=Europe/Budapest
/system identity set name="WG_ID 1"
/interface wireguard peers add allowed-address=10.20.1.2/32,10.10.2.0/28 comment="WID 2" interface=wg-workshop persistent-keepalive=1m public-key="ZWn0gaTFwzOUtojHKnZKU2rAdS9uFAy3IdSy2qVnOA8="
/ip route add disabled=no distance=1 dst-address=10.10.2.0/28 gateway=10.20.1.2 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.3/32,10.10.3.0/28 comment="WID 3" interface=wg-workshop persistent-keepalive=1m public-key="In6hFP2X+qrCWDmK+DZ0Z4xLXagcWHCjSfuD/IgamFI="
/ip route add disabled=no distance=1 dst-address=10.10.3.0/28 gateway=10.20.1.3 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.4/32,10.10.4.0/28 comment="WID 4" interface=wg-workshop persistent-keepalive=1m public-key="uZ7Fnfh/5ra0zNC25lH60J+iOQZl4bruORw0+8NrXj4="
/ip route add disabled=no distance=1 dst-address=10.10.4.0/28 gateway=10.20.1.4 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.5/32,10.10.5.0/28 comment="WID 5" interface=wg-workshop persistent-keepalive=1m public-key="64LgJ+HV1FDKzFJeJ8LcGCoMtg9R1mohTHbjT79UUCg="
/ip route add disabled=no distance=1 dst-address=10.10.5.0/28 gateway=10.20.1.5 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.6/32,10.10.6.0/28 comment="WID 6" interface=wg-workshop persistent-keepalive=1m public-key="ccRoaii+F2NT+TdedxQ9zcPGi4RHFtj/aWdI/fO7zC8="
/ip route add disabled=no distance=1 dst-address=10.10.6.0/28 gateway=10.20.1.6 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.7/32,10.10.7.0/28 comment="WID 7" interface=wg-workshop persistent-keepalive=1m public-key="aSQ/NUjJzIBAGI/RqGar/EPzb/MsigIcnLCygN0OYDI="
/ip route add disabled=no distance=1 dst-address=10.10.7.0/28 gateway=10.20.1.7 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.8/32,10.10.8.0/28 comment="WID 8" interface=wg-workshop persistent-keepalive=1m public-key="QVvxY2oZUoeVVUHpiWRg3yNt7lLCcgVprKmsEX3hhkI="
/ip route add disabled=no distance=1 dst-address=10.10.8.0/28 gateway=10.20.1.8 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.9/32,10.10.9.0/28 comment="WID 9" interface=wg-workshop persistent-keepalive=1m public-key="8ZyqbW1vG5fhnEcFgIz0opJNiGy+X9kQ0FTBjJUUF0Y="
/ip route add disabled=no distance=1 dst-address=10.10.9.0/28 gateway=10.20.1.9 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.10/32,10.10.10.0/28 comment="WID 10" interface=wg-workshop persistent-keepalive=1m public-key="ng5Rp0Bb9rzdDHYm5G/mlE0P6cAeREV6XrurMvMJ6FE="
/ip route add disabled=no distance=1 dst-address=10.10.10.0/28 gateway=10.20.1.10 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.11/32,10.10.11.0/28 comment="WID 11" interface=wg-workshop persistent-keepalive=1m public-key="sWa2LY50lP1sS0s6phQXawTvLwU2ENtnFZ6vVQDFo0g="
/ip route add disabled=no distance=1 dst-address=10.10.11.0/28 gateway=10.20.1.11 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.12/32,10.10.12.0/28 comment="WID 12" interface=wg-workshop persistent-keepalive=1m public-key="2HAgwSHkNm3Al+DXbaEobRZ0FJCgHVkHSD2LeWTsWRc="
/ip route add disabled=no distance=1 dst-address=10.10.12.0/28 gateway=10.20.1.12 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.13/32,10.10.13.0/28 comment="WID 13" interface=wg-workshop persistent-keepalive=1m public-key="/y8u6KK2lCu9vUqUJqR38MIKdqmUxHgws9MsAsD+S2w="
/ip route add disabled=no distance=1 dst-address=10.10.13.0/28 gateway=10.20.1.13 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.14/32,10.10.14.0/28 comment="WID 14" interface=wg-workshop persistent-keepalive=1m public-key="AvRb/Y997g5BwnKEM8fv1I1mPtMG5WpNW6mXOKDHNXo="
/ip route add disabled=no distance=1 dst-address=10.10.14.0/28 gateway=10.20.1.14 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.15/32,10.10.15.0/28 comment="WID 15" interface=wg-workshop persistent-keepalive=1m public-key="NPo3jsvpEeZbHPkAMS9ChkoSc+32kAa48v/IIZXfHiQ="
/ip route add disabled=no distance=1 dst-address=10.10.15.0/28 gateway=10.20.1.15 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.16/32,10.10.16.0/28 comment="WID 16" interface=wg-workshop persistent-keepalive=1m public-key="/RgN92U+iJDPkG1B9jP8dV4dV0osbNMZSE/X+4z6SFs="
/ip route add disabled=no distance=1 dst-address=10.10.16.0/28 gateway=10.20.1.16 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.17/32,10.10.17.0/28 comment="WID 17" interface=wg-workshop persistent-keepalive=1m public-key="2iGSGcL0aEVC8yMqIa48sJ/D/UwQ1Mr346y+UY2I3yo="
/ip route add disabled=no distance=1 dst-address=10.10.17.0/28 gateway=10.20.1.17 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.18/32,10.10.18.0/28 comment="WID 18" interface=wg-workshop persistent-keepalive=1m public-key="zJ3278QNvPjFifMphhw6/X5FPBMTjNnh+xu/odYnbkc="
/ip route add disabled=no distance=1 dst-address=10.10.18.0/28 gateway=10.20.1.18 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.19/32,10.10.19.0/28 comment="WID 19" interface=wg-workshop persistent-keepalive=1m public-key="M64BdpmjZfzyAfxg5sUQBZ4ZF8xkMwsNqQQYNFFD4Ag="
/ip route add disabled=no distance=1 dst-address=10.10.19.0/28 gateway=10.20.1.19 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/interface wireguard peers add allowed-address=10.20.1.20/32,10.10.20.0/28 comment="WID 20" interface=wg-workshop persistent-keepalive=1m public-key="NsZIEE1mcMrEVo+ZK2rg1sdF6v+RUeEfxYiP3cxHsyk="
/ip route add disabled=no distance=1 dst-address=10.10.20.0/28 gateway=10.20.1.20 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
