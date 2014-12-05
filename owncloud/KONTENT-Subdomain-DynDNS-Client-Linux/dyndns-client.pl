#!/usr/bin/perl -w
use LWP::UserAgent;
use strict;
use Digest::MD5  qw(md5 md5_hex md5_base64);

#################################################################
# dynDNS-DOMAINLISTE
#
# Tragen Sie hier ihre dynDNS-Domains samt Passwort ein
#
#################################################################
my %Domainlist = ("digitill-network.de" => "5S4StE5e"); #,
		  #"domain2" => "password2");

my $domain;
my $password;
my $answer  = "";
my $version = "KONTENT dynDNS Perl 1.32";


# @ARGV - Parameter von Konsole auslesen
if (defined($ARGV[0]) && ($ARGV[0] eq "on" || $ARGV[0] eq "off")) {
   
  while (($domain, $password) = each(%Domainlist)) {

    my $offline  = 0;


    # Server offline
    if ($ARGV[0] eq "off") {
      $offline = "y";
    } else {
      $offline = "n";
    }

    my $hash = Digest::MD5->new;
    $hash->add($password);

    my $url     = "http://dyndns.kontent.de/ipchangenew.php?login=$domain&password=".$hash->hexdigest."&offline=".$offline."&version=Perl1.32";

    my $referer = "";

    my $agent = LWP::UserAgent->new();
    $agent->agent($version);


    my $request = HTTP::Request->new('GET',$url);
    my $result = $agent->request($request);

    my $answer = $result->content();

    if ($answer =~ /\+OK/g) {
      print substr($answer,4)."\n";
    } elsif ($answer =~ /\+ERR/g) {
      print "Fehler: ".substr($answer,5)."\n";
    } else {
      print "Fehler: Es konnte keine Verbindung zum Server hergestellt werden.\n";
    }
  }
} else {
  print "\nFehler: Parameter ist falsch oder fehlt (on|off)\r\n";
}
