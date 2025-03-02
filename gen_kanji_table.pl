#!/usr/local/bin/perl

# SPDX-License-Identifier: MIT
# Copyright 2025 <kattyo@abk.nu>

use strict;
use warnings;
use Getopt::Long;

my $opt_list = 0;
my $opt_charset = 'sjis';
my $opt_range = 'necibm';
my $opt_newline = 'crlf';

#inv_char option for sjis
# 0x3d3d		# == (ascii representation of geta)
# 0x81ac (U+3013)	# geta (traditional representation of invalid char in Japan)
#

my $default_sjis_invchar = 0x3d3d;

my %range_map = (
	sjis => {
		nec => {
			desc => 'NEC special-char',
			inv_char => $default_sjis_invchar,
			codemap => {
				0x8740 => 0x879c
			},
			getahole => [
				0x875e,
				0x8776, 0x8777, 0x8778, 0x8779, 0x877a, 0x877b, 0x877c, 0x877d,
				0x877f
			]
		},
		ibm => {
			desc => 'IBM ext-kanji',
			inv_char => $default_sjis_invchar,
			codemap => {
				0xfa40 => 0xfa7e,
				0xfa80 => 0xfafc,
				0xfb40 => 0xfb7e,
				0xfb80 => 0xfbfc,
				0xfc40 => 0xfc4b
			},
			getahole => [
				0
			]
		},
		necibm => {
			desc => 'NEC Selected IBM ext-kanji',
			inv_char => $default_sjis_invchar,
			codemap => {
				0xed40 => 0xedfc,
				0xee40 => 0xee7e,
				0xee80 => 0xeefc
			},
			getahole => [
				0xed7f,
				0xedfd, 0xedfe, 0xedff,
				0xee7f,
				0xeeed, 0xeeee
			]
		}
	}
);


sub show_tab_header
{
	print "    =   0  1  2  3  4  5  6  7   8  9  a  b  c  d  e  f";
}

sub show_code_table
{
	my ($encoding, $range_name) = @_;
	my ($range) = $range_map{$encoding}{$range_name};
	my ($inv_char) = $range_map{$encoding}{$range_name}{inv_char};

	printf("%s in %s\n\n", $range->{desc}, $encoding);

	foreach my $start (sort keys %{$range->{codemap}}) {
		my ($end) = $range->{codemap}{$start};
		show_tab_header();
		for (my $x = $start; $x <= $end; $x++)  {
			if (($x & 0x000f) == 0 ) {
				printf("\n%04x:", $x);
			}
			print " " x (($x & 0x007) == 0);
			if (grep($_ == $x, @{$range->{getahole}})) {
				printf(" %c%c", $inv_char >> 8, $inv_char & 0xff);
			}
			else {
				printf(" %c%c", ($x >> 8) & 0xff, $x & 0xff);
			}
		}
		if (($end & 0x0f) != 0x0f) {
			print ' <';
		}
		print "\n";
	}
}

sub list_charset_range
{
	printf(" %10s  %-13s %s\n", "CHARSET", "RANGE_NAME", "DESCRIPTION");
	foreach my $encoding (sort keys %range_map) {
		foreach my $range_name (sort keys %{$range_map{$encoding}}) {
			printf(" %10s  %-13s %s\n", 
				$encoding,
				$range_name,
				$range_map{$encoding}->{"$range_name"}{desc}
				);
		}
	}
}

sub usage 
{
print <<EOS;
usage: $0 -l | [-C charset] [-R range_name]
options:
 -l                    list up charset and range names

 -C charset            select charset: [sjis]
 --charset=charset      defulat: $opt_charset

 -R range_name	       specify range name: nec, ibm, necibm
 --range=range_name     default: $opt_range

EOS
	exit(254);
}

GetOptions(
	'list|l' => \$opt_list,
	'charset|C=s' => \$opt_charset,
	'range|R=s' => \$opt_range,
	'newline|N' => \$opt_newline,
	'help|h' => \&usage
);

if ($opt_list) {
	list_charset_range();
	exit 0;
}

if (!defined $range_map{$opt_charset}) {
	print STDERR "ERROR: charset not available: $opt_charset\n";
	exit 1;
}
if (!defined $range_map{$opt_charset}{$opt_range}) {
	print STDERR "ERROR: range name not available: $opt_range\n";
	exit 2;
}

binmode(STDOUT, ":$opt_newline");

show_code_table($opt_charset, $opt_range);
