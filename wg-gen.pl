#!/usr/bin/perl -w
#	Summary:	Generate Wireguard network for RouterOS
#	Version:	0.1 (2023-05-10)
#	Package:	crowbar-labs
#	License:	GPLv3 - https://choosealicense.com/licenses/gpl-3.0/
#	Developer:	gajdost
#	Changelog:	
#	Known limits:	

#	Run:		code/wg-gen.pl 10

use strict;
use warnings;
use feature qw(say);    # For 5.10 extra function.
use File::Path qw(make_path);   # https://perldoc.perl.org/File::Path

# Global variables
my $wginterface = 'wg-workshop';
my $wgendpoint = '192.168.100.100';
my $wgport = 13231;
my $wgnetwork = '10.20.1';
my $lannetwork = '10.10';
my $idmax;
if ($#ARGV != 0) {
    say('#W# Using default values!');
	$idmax = 100;
} else {
	$idmax = $ARGV[0];
}

my @idx = (1..$idmax);
my $wgpriv;
my @wg;
my $wgpub;

my $tablef = 'table.csv';
open(TABLE,'>',$tablef) or die $!;

say("ID;\tWG-IP;\t\tLAN-IP;\t\tWG-PRIV;\t\t\t\t\tWG-PUB;");
print TABLE "ID;\tWG-IP;\tLAN-IP;\tWG-PRIV;\tWG-PUB;\n";

foreach(@idx){
    $wgpriv = `wg genkey`;
    chomp($wgpriv);
    $wgpub  = `echo '$wgpriv' | wg pubkey`;
    chomp($wgpub);
    say("$_;\t$wgnetwork.$_;\t$lannetwork.$_.1/28;\t$wgpriv;\t$wgpub;");
    print TABLE "$_;\t$wgnetwork.$_;\t$lannetwork.$_.1/28;\t$wgpriv;\t$wgpub;\n";
    $wg[$_] = {id => $_, wgip => "$wgnetwork.$_", lanip => "$lannetwork.$_.1/28", wgpriv => $wgpriv, wgpub => $wgpub};
}

close(TABLE);

# Generate server config
# id 1 is server everything else is peer

make_path('routeros-configs');
my $servercf = 'routeros-configs/server.rsc';

open(SERVER,'>',$servercf) or die $!;

say('# Server Config:');
say("/interface wireguard add listen-port=$wgport mtu=1420 name=$wginterface private-key=\"$wg[1]{wgpriv}\"");
print SERVER "/interface wireguard add listen-port=$wgport mtu=1420 name=$wginterface private-key=\"$wg[1]{wgpriv}\"\n";
say("/ip pool add name=local_$wg[1]{id} ranges=$lannetwork.$wg[1]{id}.2-$lannetwork.$wg[1]{id}.14");
print CLIENT "/ip pool add name=local_$wg[1]{id} ranges=$lannetwork.$wg[1]{id}.2-$lannetwork.$wg[1]{id}.14\n";
say("/ip dhcp-server add address-pool=local_$wg[1]{id} interface=bridge name=dhcp_$wg[1]{id}");
print CLIENT "/ip dhcp-server add address-pool=local_$wg[1]{id} interface=bridge name=dhcp_$wg[1]{id}\n";
say('/interface list add name=VPN');
print SERVER "/interface list add name=VPN\n";
say("/interface list member add interface=$wginterface list=VPN");
print SERVER "/interface list member add interface=$wginterface list=VPN\n";
say("/ip address add address=$wgnetwork.$wg[1]{id}/24 interface=$wginterface network=$wgnetwork.0");
print SERVER "/ip address add address=$wgnetwork.$wg[1]{id}/24 interface=$wginterface network=$wgnetwork.0\n";
say("/ip address add address=$lannetwork.$wg[1]{id}.1/28 interface=bridge network=$lannetwork.$wg[1]{id}.0");
print CLIENT "/ip address add address=$lannetwork.$wg[1]{id}.1/28 interface=bridge network=$lannetwork.$wg[1]{id}.0\n";
say("/ip dhcp-server network add address=$lannetwork.$wg[1]{id}.0/28 dns-server=$lannetwork.$wg[1]{id}.1 gateway=$lannetwork.$wg[1]{id}.1");
print CLIENT "/ip dhcp-server network add address=$lannetwork.$wg[1]{id}.0/28 dns-server=$lannetwork.$wg[1]{id}.1 gateway=$lannetwork.$wg[1]{id}.1\n";
say('/ip firewall mangle add action=change-mss chain=forward new-mss=1300 out-interface=ether1 protocol=tcp tcp-flags=syn tcp-mss=1301-65535');
print SERVER "/ip firewall mangle add action=change-mss chain=forward new-mss=1300 out-interface=ether1 protocol=tcp tcp-flags=syn tcp-mss=1301-65535\n";
say('/system ntp client set enabled=yes');
print SERVER "/system ntp client set enabled=yes\n";
say('/system clock set time-zone-name=Europe/Budapest');
print SERVER "/system clock set time-zone-name=Europe/Budapest\n";
say("/system identity set name=\"WG_ID $wg[1]{id}\"");
print SERVER "/system identity set name=\"WG_ID $wg[1]{id}\"\n";

foreach(@idx){
    unless($wg[$_]{id} == 1){
        say("/interface wireguard peers add allowed-address=$wgnetwork.$wg[$_]{id}/32,$lannetwork.$wg[$_]{id}.0/28 comment=\"WID $wg[$_]{id}\" interface=$wginterface persistent-keepalive=1m public-key=\"$wg[$_]{wgpub}\"");
        print SERVER "/interface wireguard peers add allowed-address=$wgnetwork.$wg[$_]{id}/32,$lannetwork.$wg[$_]{id}.0/28 comment=\"WID $wg[$_]{id}\" interface=$wginterface persistent-keepalive=1m public-key=\"$wg[$_]{wgpub}\"\n";
        say("/ip route add disabled=no distance=1 dst-address=$lannetwork.$wg[$_]{id}.0/28 gateway=$wgnetwork.$wg[$_]{id} pref-src=\"\" routing-table=main scope=30 suppress-hw-offload=no target-scope=10");
        print SERVER "/ip route add disabled=no distance=1 dst-address=$lannetwork.$wg[$_]{id}.0/28 gateway=$wgnetwork.$wg[$_]{id} pref-src=\"\" routing-table=main scope=30 suppress-hw-offload=no target-scope=10\n";
        say("/interface eoip add name=eoip-$wg[$_]{id} remote-address=$wgnetwork.$wg[$_]{id} tunnel-id=$wg[$_]{id}");
        print SERVER "/interface eoip add name=eoip-$wg[$_]{id} remote-address=$wgnetwork.$wg[$_]{id} tunnel-id=$wg[$_]{id}\n";
        say("/interface bridge port add bridge=bridge-workshop interface=eoip-$wg[$_]{id}");
        print SERVER "/interface bridge port add bridge=bridge-workshop interface=eoip-$wg[$_]{id}\n";
    }
}

close(SERVER);

say('# Server Config END');
say('# RouterOS Client Config:');
foreach(@idx){
    unless($wg[$_]{id} == 1){
        say("#ID $wg[$_]{id}:");

        my $clientcf = "routeros-configs/client_$wg[$_]{id}.rsc";

        open(CLIENT,'>',$clientcf) or die $!;

        say("/interface wireguard add listen-port=$wgport mtu=1420 name=$wginterface private-key=\"$wg[$_]{wgpriv}\"");
        print CLIENT "/interface wireguard add listen-port=$wgport mtu=1420 name=$wginterface private-key=\"$wg[$_]{wgpriv}\"\n";
        say('/interface bridge add name=bridge-eoip');
        print CLIENT "/interface bridge add name=bridge-eoip\n";
        say("/interface eoip add name=eoip-workshop remote-address=$wgnetwork.$wg[1]{id} tunnel-id=$wg[$_]{id}");
        print CLIENT "/interface eoip add name=eoip-workshot remote-address=$wgnetwork.$wg[1]{id} tunnel-id=$wg[$_]{id}\n";
        say("/ip pool add name=local_$wg[$_]{id} ranges=$lannetwork.$wg[$_]{id}.2-$lannetwork.$wg[$_]{id}.14");
        print CLIENT "/ip pool add name=local_$wg[$_]{id} ranges=$lannetwork.$wg[$_]{id}.2-$lannetwork.$wg[$_]{id}.14\n";
        say("/ip dhcp-server add address-pool=local_$wg[$_]{id} interface=bridge name=dhcp_$wg[$_]{id}");
        print CLIENT "/ip dhcp-server add address-pool=local_$wg[$_]{id} interface=bridge name=dhcp_$wg[$_]{id}\n";
        say('/routing table add disabled=no fib name=wg');
        print CLIENT "/routing table add disabled=no fib name=wg\n";
        say('/interface list add name=VPN');
        print CLIENT "/interface list add name=VPN\n";
        say("/interface bridge port add bridge=bridge-workshop interface=eoip-workshop");
        print CLIENT "/interface bridge port add bridge=bridge-workshop interface=eoip-workshop\n";
        say("/interface list member add interface=$wginterface list=VPN");
        print CLIENT "/interface list member add interface=$wginterface list=VPN\n";
        say("/ip address add address=$wgnetwork.$wg[$_]{id}/24 interface=$wginterface network=$wgnetwork.0");
        print CLIENT "/ip address add address=$wgnetwork.$wg[$_]{id}/24 interface=$wginterface network=$wgnetwork.0\n";
        say("/ip address add address=$lannetwork.$wg[$_]{id}.1/28 interface=bridge network=$lannetwork.$wg[$_]{id}.0");
        print CLIENT "/ip address add address=$lannetwork.$wg[$_]{id}.1/28 interface=bridge network=$lannetwork.$wg[$_]{id}.0\n";
        say("/ip dhcp-server network add address=$lannetwork.$wg[$_]{id}.0/28 dns-server=$wgnetwork.$wg[1]{id} gateway=$lannetwork.$wg[$_]{id}.1");
        print CLIENT "/ip dhcp-server network add address=$lannetwork.$wg[$_]{id}.0/28 dns-server=$wgnetwork.$wg[1]{id} gateway=$lannetwork.$wg[$_]{id}.1\n";
        say("/ip firewall mangle add action=mark-routing chain=prerouting new-routing-mark=wg disabled=yes comment=\"route every traffic into the tunnel\" passthrough=yes src-address=$lannetwork.$wg[$_]{id}.0/28");
        print CLIENT "/ip firewall mangle add action=mark-routing chain=prerouting new-routing-mark=wg disabled=yes comment=\"route every traffic into the tunnel\" passthrough=yes src-address=$lannetwork.$wg[$_]{id}.0/28\n";
        say("/ip firewall address-list add address=$lannetwork.$wg[$_]{id}.0/28 list=LOCAL$wg[$_]{id}");
        print CLIENT "/ip firewall address-list add address=$lannetwork.$wg[$_]{id}.0/28 list=LOCAL$wg[$_]{id}\n";
        say("/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=$wgnetwork.$wg[1]{id} pref-src=\"\" routing-table=wg scope=30 suppress-hw-offload=no target-scope=10");
        print CLIENT "/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=$wgnetwork.$wg[1]{id} pref-src=\"\" routing-table=wg scope=30 suppress-hw-offload=no target-scope=10\n";
        say('/system ntp client set enabled=yes');
        print CLIENT "/system ntp client set enabled=yes\n";
        say('/system clock set time-zone-name=Europe/Budapest');
        print CLIENT "/system clock set time-zone-name=Europe/Budapest\n";
        say("/system identity set name=\"WG_ID $wg[$_]{id}\"");
        print CLIENT "/system identity set name=\"WG_ID $wg[$_]{id}\"\n";

        say("/interface wireguard peers add allowed-address=$wgnetwork.$wg[1]{id}/32,$lannetwork.$wg[1]{id}.0/28,$lannetwork.0.0/16 endpoint-address=$wgendpoint endpoint-port=$wgport comment=\"WID $wg[1]{id}\" interface=$wginterface persistent-keepalive=1m public-key=\"$wg[1]{wgpub}\"");
        print CLIENT "/interface wireguard peers add allowed-address=$wgnetwork.$wg[1]{id}/32,$lannetwork.$wg[1]{id}.0/28,$lannetwork.0.0/16 endpoint-address=$wgendpoint endpoint-port=$wgport comment=\"WID $wg[1]{id}\" interface=$wginterface persistent-keepalive=1m public-key=\"$wg[1]{wgpub}\"\n";
        say("/ip route add disabled=no distance=1 dst-address=$lannetwork.$wg[1]{id}.0/28 gateway=$wgnetwork.$wg[1]{id} pref-src=\"\" routing-table=main scope=30 suppress-hw-offload=no target-scope=10");
        print CLIENT "/ip route add disabled=no distance=1 dst-address=$lannetwork.$wg[1]{id}.0/28 gateway=$wgnetwork.$wg[1]{id} pref-src=\"\" routing-table=main scope=30 suppress-hw-offload=no target-scope=10\n";

        close(CLIENT);

        say("#ID $wg[$_]{id} END");
    }
}

say('# RouterOS Client Config END');

say('# Regular Client Config');
say('### TODO ###');
say('# Regular Client Config END');