package Muse::Lang;
use strict;
use warnings;
use Muse::Grammar;
use Muse qw/metadata/;
use Data::Dumper;
use base qw/Exporter/;
our @EXPORT = qw/ check /;

our $DEBUG = 0;

sub check
{
	my ($rules, @files) = @_;
	-f $rules or die "$rules: $!\n";

	my %info = map { $_ => metadata $_ } @files;
	$rules = Muse::Grammar->parse($rules);
	print STDERR Dumper($rules) if $DEBUG;

	for (@$rules) {
		die "Malformed opcodes in abstract syntax tree!\n"
			unless $_->{rule} and $_->{expr};

		for my $f (@files) {
			next if $_->{cond} and !_eval($f, $info{$f}, $_->{cond});

			if (!_eval($f, $info{$f}, $_->{expr})) {
				print  "$_->{rule}\n  !! $f\n";
				printf "     %20s : %s\n", $_, $info{$f}{$_} for sort keys %{$info{$f}};
				print "\n";
			}
		}
	}
}

sub _esc { my $s = $_[0]; $s =~ s|/|_|g; $s; }
sub _val
{
	my ($I, $e) = @_;
	$e =~ s/{{([^:}]+):%([^}]+)}}/sprintf("%$2",_esc($I->{$1}||''))/ge;
	$e =~ s/{{([^}]+)}}/_esc($I->{$1}||'')/ge;
	$e;
}

sub _pat
{
	my ($I, $e) = @_;
	$e =~ s/{{([^:}]+):%([^}]+)}}/quotemeta(sprintf("%$2",_esc($I->{$1}||'')))/ge;
	$e =~ s/{{([^}]+)}}/quotemeta(_esc($I->{$1}||''))/ge;
	qr/$e/;
}

sub _eval
{
	my ($f, $I, $e) = @_;
	my $x;

	print STDERR "... checking $f\n", Dumper({ info => $I }),
	             "... opcode:\n", Dumper($e),
	             "\n\n" if $DEBUG;

	if ($x = $e->{empty}) { return !exists $I->{$x}      || $I->{$x}      eq '' }
	if ($x = $e->{'='})   { return  exists $I->{$x->[0]} && $I->{$x->[0]} eq _val($I, $x->[1]) }
	if ($x = $e->{'!='})  { return  exists $I->{$x->[0]} && $I->{$x->[0]} ne _val($I, $x->[1]) }
	if ($x = $e->{'~'})   { return  exists $I->{$x->[0]} && $I->{$x->[0]} =~ _pat($I, $x->[1]) }
	if ($x = $e->{'!~'})  { return  exists $I->{$x->[0]} && $I->{$x->[0]} !~ _pat($I, $x->[1]) }
	if ($x = $e->{'>'})   { return  exists $I->{$x->[0]} && $I->{$x->[0]} >  _val($I, $x->[1]) }
	if ($x = $e->{'>='})  { return  exists $I->{$x->[0]} && $I->{$x->[0]} >= _val($I, $x->[1]) }
	if ($x = $e->{'<'})   { return  exists $I->{$x->[0]} && $I->{$x->[0]} <  _val($I, $x->[1]) }
	if ($x = $e->{'<='})  { return  exists $I->{$x->[0]} && $I->{$x->[0]} <= _val($I, $x->[1]) }
	if ($x = $e->{not})   { return !_eval($f, $I, $x) }
	if ($x = $e->{and})   { return  _eval($f, $I, $x->[0]) && _eval($f, $I, $x->[1]) }
	if ($x = $e->{or})    { return  _eval($f, $I, $x->[0]) || _eval($f, $I, $x->[1]) }
	die "Unhandled opcode!\n";
}

1;
