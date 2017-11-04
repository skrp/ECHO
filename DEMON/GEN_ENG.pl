#!/usr/local/bin/perl
use strict; use warnings;
use File::Copy;
use Digest::SHA ();
#
###################
# ENTROPY GENERATOR 

my $log = '/usr/home/geni/o/ENTROPY_GEN.log';
open(my $Lfh, '>>', $log);

my $home = '/root/';
my $tpath = '/root/.tmp_krip';
my $path = '/zroot/krip/';

my $curve = 'prime256v1';

while (1)
{
	rotate($curve);
# FORCE RESEED
	`echo '' > /dev/random`; 
	rotate($curve);
	rotate($curve);
	rotate($curve);
	rotate($curve);
	rotate($curve);
	rotate($curve);
	rotate($curve);
	rotate($curve);
	rotate($curve);

}


sub rotate
{
#	my ($curve) = @_;
	sleep 100;
	`cd $home`;
	unlink $tpath;
	`openssl ecparam -name prime256v1 -genkey -out $tpath -param_enc explicit`; 
	my $sha = file_digest($tpath);
	my $new = $path.$sha;
	move($tpath, $new);
}
# FIX
sub c_up
{
	my $curve = 'prime256v1';
	return $curve;
}
sub file_digest {
	my ($filename) = @_;
	my $digester = Digest::SHA->new('sha256');
	$digester->addfile($filename, 'b');
	return $digester->hexdigest;
}
