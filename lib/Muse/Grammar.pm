####################################################################
#
#    This file was generated using Parse::Yapp version 1.05.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package Muse::Grammar;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
use Parse::Yapp::Driver;



sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.05',
                                  yystates =>
[
	{#State 0
		DEFAULT => -1,
		GOTOS => {
			'rules' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'' => 3,
			'IDENTIFIER' => 4
		},
		GOTOS => {
			'rule' => 2
		}
	},
	{#State 2
		DEFAULT => -2
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		ACTIONS => {
			"(" => 6,
			":" => 5
		}
	},
	{#State 5
		ACTIONS => {
			'FIELD' => 9,
			"(" => 7,
			'NOT' => 10
		},
		DEFAULT => -5,
		GOTOS => {
			'expr' => 8
		}
	},
	{#State 6
		ACTIONS => {
			'FIELD' => 9,
			"(" => 7,
			'NOT' => 10
		},
		DEFAULT => -5,
		GOTOS => {
			'expr' => 11
		}
	},
	{#State 7
		ACTIONS => {
			'NOT' => 10,
			"(" => 7,
			'FIELD' => 9
		},
		DEFAULT => -5,
		GOTOS => {
			'expr' => 12
		}
	},
	{#State 8
		ACTIONS => {
			'OR' => 15,
			";" => 13,
			'AND' => 14
		}
	},
	{#State 9
		ACTIONS => {
			'CMP' => 20,
			'IS' => 18,
			'EXISTS' => 19,
			'EQ' => 17,
			'MATCH' => 16
		}
	},
	{#State 10
		ACTIONS => {
			'NOT' => 10,
			"(" => 7,
			'FIELD' => 9
		},
		DEFAULT => -5,
		GOTOS => {
			'expr' => 21
		}
	},
	{#State 11
		ACTIONS => {
			")" => 22,
			'AND' => 14,
			'OR' => 15
		}
	},
	{#State 12
		ACTIONS => {
			")" => 23,
			'AND' => 14,
			'OR' => 15
		}
	},
	{#State 13
		DEFAULT => -3
	},
	{#State 14
		ACTIONS => {
			'NOT' => 10,
			"(" => 7,
			'FIELD' => 9
		},
		DEFAULT => -5,
		GOTOS => {
			'expr' => 24
		}
	},
	{#State 15
		ACTIONS => {
			'NOT' => 10,
			"(" => 7,
			'FIELD' => 9
		},
		DEFAULT => -5,
		GOTOS => {
			'expr' => 25
		}
	},
	{#State 16
		ACTIONS => {
			'PATTERN' => 26
		}
	},
	{#State 17
		ACTIONS => {
			'NUMBER' => 31,
			'STRING' => 30,
			'FIELD' => 28
		},
		GOTOS => {
			'value' => 29,
			'field' => 27
		}
	},
	{#State 18
		ACTIONS => {
			'EMPTY' => 33,
			'NOT' => 32
		}
	},
	{#State 19
		DEFAULT => -14
	},
	{#State 20
		ACTIONS => {
			'FIELD' => 28,
			'NUMBER' => 36
		},
		GOTOS => {
			'number' => 34,
			'field' => 35
		}
	},
	{#State 21
		ACTIONS => {
			'AND' => 14,
			'OR' => 15
		},
		DEFAULT => -8
	},
	{#State 22
		ACTIONS => {
			":" => 37
		}
	},
	{#State 23
		DEFAULT => -15
	},
	{#State 24
		DEFAULT => -6
	},
	{#State 25
		DEFAULT => -7
	},
	{#State 26
		DEFAULT => -10
	},
	{#State 27
		DEFAULT => -18
	},
	{#State 28
		DEFAULT => -21
	},
	{#State 29
		DEFAULT => -9
	},
	{#State 30
		DEFAULT => -16
	},
	{#State 31
		DEFAULT => -17
	},
	{#State 32
		ACTIONS => {
			'EMPTY' => 38
		}
	},
	{#State 33
		DEFAULT => -12
	},
	{#State 34
		DEFAULT => -11
	},
	{#State 35
		DEFAULT => -20
	},
	{#State 36
		DEFAULT => -19
	},
	{#State 37
		ACTIONS => {
			'NOT' => 10,
			"(" => 7,
			'FIELD' => 9
		},
		DEFAULT => -5,
		GOTOS => {
			'expr' => 39
		}
	},
	{#State 38
		DEFAULT => -13
	},
	{#State 39
		ACTIONS => {
			'OR' => 15,
			";" => 40,
			'AND' => 14
		}
	},
	{#State 40
		DEFAULT => -4
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'rules', 0,
sub
#line 6 "lang/muse.yp"
{ [] }
	],
	[#Rule 2
		 'rules', 2,
sub
#line 7 "lang/muse.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 3
		 'rule', 4,
sub
#line 10 "lang/muse.yp"
{ { rule => $_[1],
                                                expr => $_[3] } }
	],
	[#Rule 4
		 'rule', 7,
sub
#line 13 "lang/muse.yp"
{ { rule => $_[1],
                                                cond => $_[3],
                                                expr => $_[6] } }
	],
	[#Rule 5
		 'expr', 0,
sub
#line 18 "lang/muse.yp"
{ undef }
	],
	[#Rule 6
		 'expr', 3,
sub
#line 19 "lang/muse.yp"
{ {  and    => [ $_[1], $_[3] ] } }
	],
	[#Rule 7
		 'expr', 3,
sub
#line 20 "lang/muse.yp"
{ {  or     => [ $_[1], $_[3] ] } }
	],
	[#Rule 8
		 'expr', 2,
sub
#line 21 "lang/muse.yp"
{ {  not    =>   $_[2]          } }
	],
	[#Rule 9
		 'expr', 3,
sub
#line 22 "lang/muse.yp"
{ { "$_[2]" => [ $_[1], $_[3] ] } }
	],
	[#Rule 10
		 'expr', 3,
sub
#line 23 "lang/muse.yp"
{ { "$_[2]" => [ $_[1], $_[3] ] } }
	],
	[#Rule 11
		 'expr', 3,
sub
#line 24 "lang/muse.yp"
{ { "$_[2]" => [ $_[1], $_[3] ] } }
	],
	[#Rule 12
		 'expr', 3,
sub
#line 26 "lang/muse.yp"
{ {  empty  =>   $_[1]          } }
	],
	[#Rule 13
		 'expr', 4,
sub
#line 27 "lang/muse.yp"
{ { "!="    => [ $_[1], ""    ] } }
	],
	[#Rule 14
		 'expr', 2,
sub
#line 28 "lang/muse.yp"
{ { "!="    => [ $_[1], ""    ] } }
	],
	[#Rule 15
		 'expr', 3,
sub
#line 30 "lang/muse.yp"
{ $_[2] }
	],
	[#Rule 16
		 'value', 1, undef
	],
	[#Rule 17
		 'value', 1, undef
	],
	[#Rule 18
		 'value', 1, undef
	],
	[#Rule 19
		 'number', 1, undef
	],
	[#Rule 20
		 'number', 1, undef
	],
	[#Rule 21
		 'field', 1,
sub
#line 42 "lang/muse.yp"
{ "{{$_[1]}}" }
	]
],
                                  @_);
    bless($self,$class);
}

#line 45 "lang/muse.yp"


sub _q { my ($s, $l) = @_; $s =~ s/\\([$l])/$1/g; $s }
sub _f { my ($s) = @_; $s =~ s/-//;
                       $s =~ s/disk/disc/;
                       $s =~ s/sort$/sortname/;
                       $s =~ s/^discs$/totaldisc/;
                       $s =~ s/^tracks$/totaltracks/;
                       $s }
sub _  { use Data::Dumper; print STDERR Dumper(\@_); @_ }

sub yyerror
{
	my ($Y) = @_;
	my ($tok, $val, $expect) = ($Y->YYCurtok, $Y->YYCurval, $Y->YYExpect);
	my ($file, $line) = ($Y->YYData->{FILE}, $Y->YYData->{LINE});

	if (lc($tok) eq lc($val)) {
		die "syntax error at $file:$line: found '$val' token where we expected '$expect'\n";
	} else {
		$tok = lc($tok);
		die "syntax error at $file:$line: found $tok token '$val' where we expected '$expect'\n";
	}
}

sub yylex
{
	my ($Y) = @_;
	while ($Y->YYData->{DATA} =~ s/^(\s+|#.*$)//m) {
		# ignore whitespace / comments
		$Y->YYData->{LINE}++ if $1 =~ m/\n/;
	}

	$Y->YYData->{DATA} =~ s/^(and|&&)//              and return ('AND', 'and');
	$Y->YYData->{DATA} =~ s/^(or|\|\|)//             and return ('OR',  'or');

	$Y->YYData->{DATA} =~ s/^(!?=)//                 and return ('EQ',    $1);
	$Y->YYData->{DATA} =~ s/^(!?~)//                 and return ('MATCH', $1);
	$Y->YYData->{DATA} =~ s/^([<>]=?)//              and return ('CMP',   $1);

	$Y->YYData->{DATA} =~ s/^( [+-]?
	                           \d+
	                           (?: \.\d+)     ?
	                           (?: e[+-]?\d+) ?
	                         )//x                    and return ('NUMBER', $1);

	$Y->YYData->{DATA} =~ s/^( is
	                         | not
	                         | empty
	                         | exists
	                         )\b//xi                 and return (uc($1), lc($1));

	$Y->YYData->{DATA} =~ s/^( path
	                         | filename
	                         )\b//xi                 and return ('FIELD', "_$1");

	$Y->YYData->{DATA} =~ s/^( album-?artist
	                         | album-?rating
	                         | album-?sort
	                         )\b//xi                 and return ('FIELD', _f($1));

	$Y->YYData->{DATA} =~ s/^( album
	                         | artist
	                         | original-?artist
	                         | composer
	                         | asin
	                         | upc
	                         | title
	                         | compilation
	                         | sort
	                         | genre
	                         | comment
	                         | copyright
	                         | rating
	                         | dis[kc]s?
	                         | disc-?title
	                         | tracks?
	                         | release-?date
	                         | year
	                         | mb_albumid
	                         | mb_artistid
	                         | mb_trackid
	                         | mb_puid
	                         )\b//xi                 and return ('FIELD', _f($1));

	$Y->YYData->{DATA} =~ s/^@([a-z_][a-z0-9_-]*)//i and return ('IDENTIFIER', $1);

	$Y->YYData->{DATA} =~ s!^m?/(
	                        (?:
	                          [^\n\\/]
	                          | \\\\
	                          | \\\.
	                          | \\[dsSwW]
	                          | \\\/
	                        )*?
	                       )/!!x                     and return ('PATTERN', _q($1, q{\\/}));

	$Y->YYData->{DATA} =~ s/^"(
	                        (?:
	                          [^\\"]
	                          | \\\\
	                          | \\"
	                        )*?
	                       )"//x                     and return ('STRING', _q("$1", q{\\"}));

	$Y->YYData->{DATA} =~ s/^'(
	                        (?:
	                          [^\\']
	                          | \\\\
	                          | \\'
	                        )*?
	                       )'//x                     and return ('STRING', _q("$1", q{\\'}));

	$Y->YYData->{DATA} =~ s/^(.)//                   and return ($1, $1);
	undef;
}

sub parse
{
	my ($class, $file) = @_;
	open my $fh, "<", $file
		or die "$file: $!\n";

	my $src = do { local $/; <$fh> };
	close $fh;

	$class->evaluate($src, $file);
}

sub evaluate
{
	my ($class, $src, $path) = @_;
	$path ||= '<input>';
	my $self = __PACKAGE__->new;
	$self->{USER} = {
		LINE => 1,
		FILE => $path,
		DATA => $src,
	};
	return $self->YYParse(
		yylex   => \&yylex,
		yyerror => \&yyerror,
	);
}

1;
