# if straberry perl installed (and in path), don't include the shebang (#!/usr/local/bin/perl -w)
# Surpress 5.8.0 warning: Powershell as admin: [Environment]::SetEnvironmentVariable("LC_ALL", "C")

use warnings;
use strict;
use feature qw(say);
use Data::Dumper;   # debugging

# string literal
my $num1 = 7;
my $str1 = "Interpreted Double Quotes: Hello, World. The number is $num1!";
my $str2 = "Literal Double Quotes with Escape: Hello, World. The number is \$num!";
my $str_literal = 'Literal Single Quotes: Hello, World. The number is $num!';
say $str1;
say $str2;
say $str_literal;

# readline (<>) user input continuously from terminal. print it out ($_) in upper case (uc)
# while (<>) {.
#     say uc "$_";
# }

# string concat with .
say "Str Concat with Dot: Hello there number ".$num1.". I heard you 8 9!";

# better print-style debugging with dumper module
my $str3 = "wee string";
say Dumper ( $num1, $str3 );


26mins / arrays