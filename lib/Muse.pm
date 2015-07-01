package Muse;

use strict;
use warnings;
use File::Temp qw/tempfile/;
use Digest::SHA;
use Music::Tag;
use Cwd qw/abs_path/;
use base qw/Exporter/;
our @EXPORT = qw/
	waveform_checksum

	provided_files
	fields metadata copy_metadata set_metadata

	convert
/;

my $LAST_ERROR = '';

sub last_error
{
	$LAST_ERROR;
}

sub _run
{
	my ($command) = @_;
	my $s = qx($command);
	$? and $LAST_ERROR = $s;
	return $? == 0;
}

sub _ext
{
	my ($f) = @_;
	return lc($1) if $f =~ m/\.([^.]+)$/;
	undef;
}

sub _base
{
	my ($f) = @_;
	$f =~ s/\.([^.]+)$//;
	return $f;
}

sub waveform_checksum
{
	my ($file) = @_;

	my $sha = Digest::SHA->new('sha1');

	(undef, my $tmp) = tempfile;
	unlink $tmp;

	my $ext = _ext($file)
		or die "No file extension ($file)\n";

	if ($ext eq 'ogg') {
		_run(qq(oggdec -Q -o $tmp "$file" 2>&1))
			or die "OGG Vorbis decode of $file failed\n";

	} elsif ($ext eq 'mp3') {
		_run(qq(lame --decode "$file" $tmp 2>&1))
			or die "MP3 decode of $file failed\n";

	} elsif ($ext eq 'flac') {
		_run(qq(flac -s --decode "$file" -o $tmp 2>&1))
			or die "FLAC decode of $file failed\n";

	} else {
		die "Unrecognized file extension ($file)\n";
	}

	$sha->addfile($tmp);
	unlink $tmp;
	return $sha->hexdigest;
}

sub provided_files
{
	return @ARGV if @ARGV;
	die "No files provided.\n" if -t STDIN;
	my @l; while (<STDIN>) { chomp; push @l, $_; } @l;
}

sub fields
{
	qw/
		album albumartist albumrating albumsortname
		artist originalartist composer
		compilation
		asin upc
		title compilation sortname genre
		comment copyright rating
		disc totaldisc disctitle
		discnumber
		track totaltracks
		releasedate year
		mb_albumid mb_artistid mb_trackid mb_puid
	/;
}

sub metadata
{
	my ($file) = @_;
	my $info = Music::Tag->new($_, { quiet => 1 });
	$info->get_tag;

	my %metadata;
	for (fields) {
		$metadata{$_} = $info->get_data($_)
			if $info->has_data($_);
	}
	$metadata{_path} = abs_path($file);
	($metadata{_filename} = $file) =~ s|.*/||;
	($metadata{_type} = lc($file)) =~ s/.*\.//;

	\%metadata;
}

sub copy_metadata
{
	my ($from, $to) = @_;
	set_metadata($to, metadata($from));
}

sub set_metadata
{
	my ($file, $meta) = @_;
	my $info = Music::Tag->new($file, { quiet => 1 });
	$info->get_tag;

	$info->set_data($_, $meta->{$_}) for grep { ! m/^_/ } keys %$meta;
	$info->set_tag;
}

sub convert
{
	my ($from, $fmt, $force) = @_;
	my %decode = (
		ogg => qq(oggdec -Q -o "{{X}}.wav" "{{X}}.ogg"),
		mp3 => qq(lame --decode "{{X}}.mp3" "{{X}}.wav"),
	);
	my %encode = (
		flac => qq(flac -s "{{X}}.wav" && rm "{{X}}.wav"),
	);

	my $ext  = _ext($from);
	my $base = _base($from);
	return "$base.$fmt" if -f "$base.$fmt" and !$force;

	$decode{$ext} or die "Don't know how to decode .$ext files\n";
	$encode{$fmt} or die "Don't know how to encode .$fmt files\n";

	(my $cmd1 = $decode{$ext}) =~ s/{{X}}/_base($from)/ge;
	(my $cmd2 = $encode{$fmt}) =~ s/{{X}}/_base($from)/ge;

	_run(qq($cmd1 && $cmd2))
		or return undef;

	"$base.$fmt";
}

1;
