# if straberry perl installed (and in path), don't include the shebang (#!/usr/local/bin/perl -w)
# Surpress 5.8.0 warning: Powershell as admin: [Environment]::SetEnvironmentVariable("LC_ALL", "C")

use warnings;
use strict;
use feature qw(say);

# debugging
use Data::Dumper;

# make local scalar copies ($fooX) by shifting off of @_
# @_ unaffected
sub access_by_shift_copying {
    my $foo0 = shift;
    my $foo1 = shift;
    my $foo2 = shift;
    my $foo3 = shift;
    my $foo4 = shift;
}

# simply make a local copy of @_ called @foo
# @_ unaffected
sub access_by_array_copying {
    my @foo = @_;
}

# directly change the @_ array
sub manipulate_array_directly {
    $_[0] = 9;
    $_[1] = 8;
    $_[2] = 7;
    $_[3] = 6;
    $_[4] = 5;
}

# arrays are not passed to subs, they are passed as ordered individual scalars. create a pointer to the start of this scalar list
# directly change the @_ array
sub manipulate_by_pointing_to_array_passed {
    my $foo_ptr = \@_;
    $foo_ptr->[0] = 99;
    @$foo_ptr[1]  = 88;
    $foo_ptr->[2] = 77;
    @$foo_ptr[3]  = 66;
    $foo_ptr->[4] = 55;
}

# address of array passed to subroutine, create pointer to this passed address and then manipulate its values
# directly change the @_ array via pointer
sub manipulate_by_passing_array_ADDRESS_to_sub {
    my $foo_ptr = shift;
    $foo_ptr->[0] = 9999;
    @{$foo_ptr}[1] = 8888;
    $foo_ptr->[2] = 7777;
    @$foo_ptr[3] = 6666;
    @{$foo_ptr}[4] = 5555;
}

##### Main
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

# pass by value pass by reference to sub
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

# taking an array in scalar context gives the length of the array
my $lenArr2 = @arr2;
say "array to scalar: length of \@arr2 = " . $lenArr2;

# print in uppercase only if 2 > 1
say uc "im getting changed to uppercase init" if 2 > 1;
say "";

# index -1 of array, array length and get last element of array
my @arr7 = ( 1, 2, 3, 4, 5, 6, 7 );
say "arr7 = " . join " ", @arr7;
say "arr7[-1] = " . $arr7[-1];
say "arr7[-2] = " . $arr7[-2];
say "arr7[0] = " . $arr7[0];
my $arr7_len        = @arr7;
my $arr7_last_index = $#arr7;
say "arr7 length = " . $arr7_len;
say "arr7 last index = " . $arr7_last_index;
say "";

# array .. range
say "(1..20) = " . join " ",    ( 1 .. 20 );
say '("a".."z") = ' . join ",", ( "a" .. "z" );

# note the sigil change for array split
say join " ", ( $arr7[0] );
say join " ", ( @arr7[ 0, 2 ] );
say join " ", ( @arr7[ 0 .. 2 ] );
say "";

# push, pop, shift, unshift array
my @arr8 = ( 101, 102, 103, 104, 105 );
say "arr8 = " . join " ", @arr8;
push @arr8, 1006;
say "push \@arr8, 1006 = " . join " ", @arr8;
pop @arr8;
say "pop \@arr8 = " . join " ", @arr8;
unshift @arr8, 999;
say "unshift \@arr8, 999 = " . join " ", @arr8;
shift @arr8;
say "shift \@arr8 = " . join " ", @arr8;
say "";

# sorting (perl sorts alphabetically by default, like JS)
my @arr9 = qw/h d e k t s/;
say "\@arr9 = " . join " ", @arr9;
my @arr10 = sort @arr9;
say "\@arr10 = " . join " ", @arr10;
my @arr11 = ( 4, 7, 8, 2, 3, 11 );
say "\@arr11 = " . join " ", @arr11;

# use spaceship to sort numbers
my @arr12 = sort { $a <=> $b } @arr11;
say "\@arr12 = " . join " ", @arr12;
say "";

# hashes (dictionaries), unordered in perl, keys are unique
my %dic1       = ( a => 1, b => 2, "c" => 3, "my-key" => 'My&VaLu3' );
my @print_temp = ();
while ( my ( $k, $v ) = each %dic1 ) {
    push @print_temp, "$k=>$v, ";
}
say "\%dic1 = " . join " ", @print_temp;
$dic1{"c"} = "NewValue";
@print_temp = ();
while ( my ( $k, $v ) = each %dic1 ) {
    push @print_temp, "$k=>$v, ";
}
say "\%dic1 = " . join " ", @print_temp;

# embed dic1 into dic2
my %dic2 = ( 'd' => 4, %dic1, 'e' => 5 );
@print_temp = ();
while ( my ( $k, $v ) = each %dic2 ) {
    push @print_temp, "$k=>$v, ";
}
say "\%dic2 = " . join " ", @print_temp;

# say '$dic2{$a,$b} = ' .
say join " ", @dic2{ 'c', 'e' };
say join " ", @dic2{ 'c'.. 'e' };

# creat:arrayList=(), access: $arrayList[], split pick @arrayList[2,5], split range: @arrayList[2..5]
# creat:dicHash=(), access: $dicHash{}, split pick @dicHash{2,5}, split range @dicHash{2..5}
