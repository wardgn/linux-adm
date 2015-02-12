#!/usr/bin/perl

use strict;
use warnings;

my @hdpUsers =
  qw/hdfs yarn mapred hive hbase hcat falcon sqoop zookeeper oozie knox /;
# qw/hadoop hdfs yarn mapred hive hbase hcat falcon sqoop zookeeper oozie knox /;
my $cmd;
my $hu;

foreach $hu (@hdpUsers) {
  my $cmd="echo $hu | passwd --stdin $hu";
  print $cmd, "\n";
  system($cmd);
};
 	
