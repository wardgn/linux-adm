#!/usr/bin/perl
use strict;
use warnings;

my @hdpUsers =
  qw/hadoop hdfs yarn mapred hive hbase hcat falcon sqoop zookeeper oozie knox /;
my %hdpAccts;
my $user;
my $pass;
my @groups;
my @addgroup;
my $g;
my $lg;
my $CmdGrpAdd;
my $CmdUserAdd;
my $CmdUserMod;

foreach $g ('hadoop', 'mapred', 'nagios') {
	$CmdGrpAdd="groupadd $g";
    system($CmdGrpAdd);
}

%hdpAccts = map { $_ => ['hadoop'] } @hdpUsers;


push @{ $hdpAccts{mapred} }, 'mapred';
push @{ $hdpAccts{nagios}}, 'nagios' ;
push @hdpUsers, "nagios";

foreach $user (keys %hdpAccts)
{
	$CmdUserMod = undef;
	@groups = $hdpAccts{$user};
	$CmdUserAdd =
	  "useradd -c $user -N -g $groups[0]->[0] $user";
	system ($CmdUserAdd);
	print $CmdUserAdd, "\n";

    $lg=$#{$groups[0]}; # last index for array referenced by groups
    while ($lg) {
          $g=$groups[0]->[$lg]	;
		  $CmdUserMod = "usermod -a -G $g $user";
		  system ($CmdUserMod);
		  print $CmdUserMod, "\n";
		  $lg--;
	};
	
	system ($CmdUserAdd);
}
exit;
