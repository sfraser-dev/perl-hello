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
say "";

# readline (<>) user input continuously from terminal. print it out ($_) in upper case (uc)
# while (<>) {.
#     say uc "$_";
# }

# string concat with .
say "Str Concat with Dot: Hello there number " . $num1 . ". I heard you 8 9!";
say "";

# better print-style debugging with dumper module
my $str3 = "wee string";
say Dumper $num1, $str3;

# array and list are used interchangeably in perl
# array is the variable (arr1)
# list is the data (22, "hello", 1.22)
my @arr1 = ( 22, "hello", 1.22 );
say join( " ", @arr1 );

say "access \$arr[2] as a scalar: $arr1[2]";
say "";

# qw quote word
# returns array / list splitting on whitespace & wrapping in 'single quotes'
# a quick way to specify a lot of little single-quoted words without the quotes
# splits into array / list on whitespace
my @qw1 = qw (101 202 303 parenthesisDelimiters);
say Dumper @qw1;
say $qw1[1];
say "";
my @qw2 = qw [1001 exclamationDelimiters       3333];
say Dumper @qw2;
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
say "";

my @arr2 = ( 1, 2, 3, 4, 5 );
my @arr3 = ( 1 .. 5 );
my @arr4 = ( 1 .. 5 );
my @arr5 = ( 1 .. 5 );
my @arr6 = ( 1 .. 5 );
say "arr2: " . join( " ", @arr2 );
say "arr3: " . join " ", @arr3;
say "arr4: " . join( " ", @arr4 );
say "arr5: " . join( " ", @arr5 );
say "arr6: " . join( " ", @arr6 );

access_by_shift_copying(@arr2);
access_by_array_copying(@arr3);
manipulate_array_directly(@arr4);
manipulate_by_pointing_to_array_passed(@arr5);
manipulate_by_passing_array_ADDRESS_to_sub( \@arr6 );

say "arr2: " . join( " ", @arr2 );
say "arr3: " . join " ", @arr3;
say "arr4: " . join " ", @arr4;
say "arr5: " . join " ", @arr5;
say "arr6: " . join " ", @arr6;
say "";

# # taking an array in scalar context gives the length of the array
my $lenArr2 = @arr2;
say "array to scalar: length of \@arr2 = " . $lenArr2;

# make local scalar copies ($fooX) by shifting off of @_
# @_ unaffected
sub access_by_shift_copying {
    my $foo0 = shift;
    my $foo1 = shift;
    my $foo2 = shift;
    my $foo3 = shift;
    my $foo4 = shift;
    say "shifty: $foo0 $foo1 $foo2 $foo3 $foo4";
}

# make a local copy (@foo) of @_
# @_ unaffected
sub access_by_array_copying {
    my @foo = @_;
    say "listy: " . join( " ", @foo );
}

# directly change the @_ array
sub manipulate_array_directly {
    $_[0] = 9;
    $_[1] = 8;
    $_[2] = 7;
    $_[3] = 6;
    $_[4] = 5;
}

# arrays are not passed to subs, they are passed as ordered individual scalars. create a point to the start of this scalar list
# directly change the @_ array
sub manipulate_by_pointing_to_array_passed {
    my $foo_ptr = \@_;
    $foo_ptr->[0] = 99;
    @$foo_ptr[1]  = 88;
    $foo_ptr->[2] = 77;
    @$foo_ptr[3]  = 66;
    $foo_ptr->[4] = 55;

}

# address of array passed to subroutine, create pointer to it and then manipulate its values
# directly change the @_ array
sub manipulate_by_passing_array_ADDRESS_to_sub {
    my $foo_ptr = shift;
    $foo_ptr->[0] = 9999;
    @{$foo_ptr}[1] = 8888;
    $foo_ptr->[2] = 7777;
    @$foo_ptr[3] = 6666;
    @{$foo_ptr}[4] = 5555;
}
