#!/usr/bin/perl -w
#	Summary:	Generate Wireguard network for RouterOS and regular clients
#	Version:	0.4 (2026-10-12)
#	Package:	crowbar-labs
#	License:	GPLv3 - https://choosealicense.com/licenses/gpl-3.0/
#	Developer:	gajdost
#	Changelog:	0.2 - regular client configs + QR codes, emit() helper, bug fixes
#			    0.3 - single WG network; args are <routeros clients> <regular clients>
#               0.4 - replace qrencode with libimager-qrcode-perl
#	Known limits:	Needs 'wg' (wireguard-tools) and optionally 'libimager-qrcode-perl'
#                   `sudo apt install libimager-qrcode-perl`
#			        Max 253 clients in total (one /24 WG network)

#	Run:		code/wg-gen.pl 10 5     # 10 RouterOS + 5 regular clients
#			    code/wg-gen.pl 0 10     # 10 regular clients only
#	The server is always generated as ID 1 (not counted in the arguments).
#	IDs: 1 = server, 2..R+1 = RouterOS clients, R+2..R+C+1 = regular clients

use strict;
use warnings;
use feature qw(say);    # For 5.10 extra function.
use File::Path qw(make_path);   # https://perldoc.perl.org/File::Path

umask 077;   # keys are written to files, keep them private

# Global variables
my $wginterface = 'wg-workshop';
my $wgendpoint = '192.168.100.100';   # use a domain name here for regular clients if you have one
my $wgport = 13231;					  # set the port
my $wgnetwork = '10.20.1';            # wireguard network
my $lannetwork = '10.10';             # network behind RouterOS peers
my ($rosmax, $rcmax);

if ($#ARGV != 1) {
    say('#W# Using default values!');
    ($rosmax, $rcmax) = (100, 0);
} else {
    ($rosmax, $rcmax) = @ARGV;
}
die "Arguments must be non-negative integers\n"
    unless $rosmax =~ /^\d+$/ && $rcmax =~ /^\d+$/;
die "Too many clients: max 253 in total\n" if $rosmax + $rcmax > 253;

my @rosids = (2 .. $rosmax + 1);
my @rcids  = ($rosmax + 2 .. $rosmax + $rcmax + 1);
my @allids = (1, @rosids, @rcids);
my %isrc   = map { $_ => 1 } @rcids;
my @wg;

# Print a line to stdout and to the given file handle
sub emit {
    my ($fh, $line) = @_;
    say($line);
    print $fh "$line\n";
}

sub genkeys {
    my $priv = `wg genkey`;
    chomp($priv);
    my $pub = `echo '$priv' | wg pubkey`;
    chomp($pub);
    return ($priv, $pub);
}

my $tablef = 'table.csv';
open(my $table, '>', $tablef) or die "$tablef: $!";

say("ID;\tTYPE;\tWG-IP;\t\tLAN-IP;\t\tWG-PRIV;\t\t\t\t\tWG-PUB;");
print $table "ID;\tTYPE;\tWG-IP;\tLAN-IP;\tWG-PRIV;\tWG-PUB;\n";

foreach my $id (@allids) {
    my ($wgpriv, $wgpub) = genkeys();
    my $type  = $id == 1 ? 'server' : $isrc{$id} ? 'regular' : 'routeros';
    my $lanip = $isrc{$id} ? '-' : "$lannetwork.$id.1/28";
    say("$id;\t$type;\t$wgnetwork.$id;\t$lanip;\t$wgpriv;\t$wgpub;");
    print $table "$id;\t$type;\t$wgnetwork.$id;\t$lanip;\t$wgpriv;\t$wgpub;\n";
    $wg[$id] = {id => $id, wgip => "$wgnetwork.$id", lanip => $lanip, wgpriv => $wgpriv, wgpub => $wgpub};
}

close($table);

# Generate server config
# id 1 is server everything else is peer

make_path('routeros-configs');
my $servercf = 'routeros-configs/server.rsc';

open(my $server, '>', $servercf) or die "$servercf: $!";

my $s = $wg[1]{id};

say('# Server Config:');
emit($server, "/interface wireguard add listen-port=$wgport mtu=1420 name=$wginterface private-key=\"$wg[1]{wgpriv}\"");
emit($server, "/ip pool add name=local_$s ranges=$lannetwork.$s.2-$lannetwork.$s.14");
emit($server, "/ip dhcp-server add address-pool=local_$s interface=bridge name=dhcp_$s");
emit($server, '/interface list add name=VPN');
emit($server, "/interface list member add interface=$wginterface list=VPN");
emit($server, "/ip address add address=$wgnetwork.$s/24 interface=$wginterface network=$wgnetwork.0");
emit($server, "/ip address add address=$lannetwork.$s.1/28 interface=bridge network=$lannetwork.$s.0");
emit($server, "/ip dhcp-server network add address=$lannetwork.$s.0/28 dns-server=$lannetwork.$s.1 gateway=$lannetwork.$s.1");
emit($server, '/ip firewall mangle add action=change-mss chain=forward new-mss=1300 out-interface=ether1 protocol=tcp tcp-flags=syn tcp-mss=1301-65535');
emit($server, '/system ntp client set enabled=yes');
emit($server, '/system clock set time-zone-name=Europe/Budapest');
emit($server, "/system identity set name=\"WG_ID $s\"");

foreach my $id (@rosids) {
    emit($server, "/interface wireguard peers add allowed-address=$wgnetwork.$id/32,$lannetwork.$id.0/28 comment=\"WID $id\" interface=$wginterface persistent-keepalive=1m public-key=\"$wg[$id]{wgpub}\"");
    emit($server, "/ip route add disabled=no distance=1 dst-address=$lannetwork.$id.0/28 gateway=$wgnetwork.$id pref-src=\"\" routing-table=main scope=30 suppress-hw-offload=no target-scope=10");
#    emit($server, "/interface eoip add name=eoip-$id remote-address=$wgnetwork.$id tunnel-id=$id");
#    emit($server, "/interface bridge port add bridge=bridge-workshop interface=eoip-$id");
}

foreach my $id (@rcids) {
    emit($server, "/interface wireguard peers add allowed-address=$wgnetwork.$id/32 comment=\"RC $id\" interface=$wginterface public-key=\"$wg[$id]{wgpub}\"");
}

close($server);

say('# Server Config END');
say('# RouterOS Client Config:');
foreach my $id (@rosids) {
    say("#ID $id:");

    my $clientcf = "routeros-configs/client_$id.rsc";
    open(my $client, '>', $clientcf) or die "$clientcf: $!";

    emit($client, "/interface wireguard add listen-port=$wgport mtu=1420 name=$wginterface private-key=\"$wg[$id]{wgpriv}\"");
    emit($client, '/interface bridge add name=bridge-workshop');
#    emit($client, "/interface eoip add name=eoip-workshop remote-address=$wgnetwork.$s tunnel-id=$id");
    emit($client, "/ip pool add name=local_$id ranges=$lannetwork.$id.2-$lannetwork.$id.14");
    emit($client, "/ip dhcp-server add address-pool=local_$id interface=bridge name=dhcp_$id");
    emit($client, '/routing table add disabled=no fib name=wg');
    emit($client, '/interface list add name=VPN');
    emit($client, '/interface bridge port add bridge=bridge-workshop interface=eoip-workshop');
    emit($client, "/interface list member add interface=$wginterface list=VPN");
    emit($client, "/ip address add address=$wgnetwork.$id/24 interface=$wginterface network=$wgnetwork.0");
    emit($client, "/ip address add address=$lannetwork.$id.1/28 interface=bridge network=$lannetwork.$id.0");
    emit($client, "/ip dhcp-server network add address=$lannetwork.$id.0/28 dns-server=$wgnetwork.$s gateway=$lannetwork.$id.1");
    emit($client, "/ip firewall mangle add action=mark-routing chain=prerouting new-routing-mark=wg disabled=yes comment=\"route every traffic into the tunnel\" passthrough=yes src-address=$lannetwork.$id.0/28");
    emit($client, "/ip firewall address-list add address=$lannetwork.$id.0/28 list=LOCAL$id");
    emit($client, "/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=$wgnetwork.$s pref-src=\"\" routing-table=wg scope=30 suppress-hw-offload=no target-scope=10");
    emit($client, '/system ntp client set enabled=yes');
    emit($client, '/system clock set time-zone-name=Europe/Budapest');
    emit($client, "/system identity set name=\"WG_ID $id\"");

    # WG subnet is a /24 so RouterOS clients can also reach the regular clients through the server
    emit($client, "/interface wireguard peers add allowed-address=$wgnetwork.0/24,$lannetwork.$s.0/28,$lannetwork.0.0/16 endpoint-address=$wgendpoint endpoint-port=$wgport comment=\"WID $s\" interface=$wginterface persistent-keepalive=1m public-key=\"$wg[1]{wgpub}\"");
    emit($client, "/ip route add disabled=no distance=1 dst-address=$lannetwork.$s.0/28 gateway=$wgnetwork.$s pref-src=\"\" routing-table=main scope=30 suppress-hw-offload=no target-scope=10");

    close($client);

    say("#ID $id END");
}

say('# RouterOS Client Config END');

say('# Regular Client Config');

make_path('client-configs');
my $have_qr = eval { require Imager::QRCode; 1 };
say('#W# Imager::QRCode not found, skipping QR codes') if !$have_qr && @rcids;

foreach my $id (@rcids) {
    my $conf = "client-configs/rc_$id.conf";
    open(my $fh, '>', $conf) or die "$conf: $!";
    print $fh <<"EOF";
[Interface]
PrivateKey = $wg[$id]{wgpriv}
ListenPort = $wgport
Address = $wgnetwork.$id/32
DNS = $wgnetwork.$s

[Peer]
PublicKey = $wg[1]{wgpub}
AllowedIPs = $wgnetwork.0/24, $lannetwork.0.0/16
Endpoint = $wgendpoint:$wgport
PersistentKeepalive = 60
EOF
    close($fh);
    say("# $conf written");

    if ($have_qr) {
        my $text = do {
            open(my $in, '<', $conf) or die "$conf: $!";
            local $/;
            <$in>;
        };
        my $qr  = Imager::QRCode->new(size => 6, margin => 4, level => 'M', casesensitive => 1);
        my $img = $qr->plot($text);
        my $png = "client-configs/rc_$id.png";
        $img->write(file => $png) or warn "QR failed for client $id: ", $img->errstr, "\n";
    }
}

say('# Regular Client Config END');
