#!/usr/local/bin/perl

use strict;
use warnings;

while(my $l = <>) {
	$l =~ s/[\r\n]+$//;
	my @a = split(/\s+/, $l);
	foreach my $token (@a) {
		if ($token =~ /^[[:ascii:]]+$/) {
			print "$token ";
			next;
		}
		my $hex = unpack( 'H*', $token);
		print "$hex ";
	}
	print "\n";
}
