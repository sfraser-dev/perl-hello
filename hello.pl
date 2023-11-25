# if straberry perl installed (and in path), don't include the shebang (#!/usr/local/bin/perl -w)
# Surpress 5.8.0 warning: Powershell as admin: [Environment]::SetEnvironmentVariable("LC_ALL", "C")

use warnings;
use strict;
use feature qw(say);

# debugging
use Data::Dumper;    

# string literal
my $num1 = 7;
my $str1 = "Interpreted Double Quotes: Hello, World. The number is $num1!";
my $str2 =
  "Literal Double Quotes with Escape: Hello, World. The number is \$num!";
my $str_literal = 'Literal Single Quotes: Hello, World. The number is $num!';
say $str1;
say $str2;
say $str_literal;
say"";

# readline (<>) user input continuously from terminal. print it out ($_) in upper case (uc)
# while (<>) {.
#     say uc "$_";
# }

# string concat with .
say "Str Concat with Dot: Hello there number " . $num1 . ". I heard you 8 9!";
say"";

# better print-style debugging with dumper module
my $str3 = "wee string";
say Dumper $num1, $str3;

# array and list are used interchangeably in perl
# array is the variable (arr1)
# list is the data (22, "hello", 1.22)
my @arr1 = ( 22, "hello", 1.22 );
say Dumper (@arr1);
say "access \$arr[2] as a scalar: $arr1[2]"; 
say"";

# qw quote word
# returns array / list splitting on whitespace & wrapping in 'single quotes'
# a quick way to specify a lot of little single-quoted words without the quotes
# splits into array / list on whitespace
my @qw1 = qw (101 202 303 parenthesisDelimiters);
say Dumper @qw1;
say $qw1[1];
say"";
my @wq2 = qw [1001 exclamationDelimiters       3333];
say Dumper @wq2;
my @qw3 = qw / fwdSlashDelimiters 999      xxrr/;
say Dumper @qw3;

# q 'single' quotes and qq "double" quotes
# there are four open / close delimiters for 'q' and "qq"
my $str4 = q(good) . q[ day] . qq< my> . q{ friend};
say $str4;
# can use identicle symbols as open and closing delimiters too
my $str5 = q!can! . qq% use% . q& identicle& . qq* delimiters* . q@ too!@; 
say $str5;
# no split into array / list with q and qq as there is with qw
my $str6 = qq/this is a double quoted sentence, no split with q or qq/;
say $str6;