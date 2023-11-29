# if straberry perl installed (and in path), don't include the shebang (#!/usr/local/bin/perl -w)
# Surpress 5.8.0 warning: Powershell as admin: [Environment]::SetEnvironmentVariable("LC_ALL", "C")

use warnings;
use strict;
use feature qw(say);

# debugging
use Data::Dumper;

# signatures for subs (became non-experimental in perl 5.36)
use feature qw(signatures);

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

# print in uppercase with tailend if statement
say uc "im getting changed to uppercase init" if 2 > 1;
say lc "IM GETTING CHANGED TO LOWERCASE INIT" if 1;
say "";

# better print-style debugging with dumper module
my $str3 = "wee string";
say Dumper $num1, $str3;

# array and list are used interchangeably in perl
# array is the variable (arr1)
# list is the data (22, "hello", 1.22)
my @arr1 = ( 22, "hello", 1.22 );
say join( " ", @arr1 );

# array to scalar context gives size / length
my $arr1_length = @arr1;
say( 'length of @arr1 is: ' . $arr1_length );

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

# array to scalar context gives size / length
my $lenArr2 = @arr2;
say "array to scalar: length of \@arr2 = " . $lenArr2;
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

# pick two distinct values from the array
say join " ", ( @arr7[ 0, 2 ] );

# split array via range
say join " ", ( @arr7[ 0 .. 2 ] );

# split pick two values: @arrayList[2,5]
# split into range: @arrayList[2..5]
# split pick two values: %dicHash{2,5}
# split into range: %dicHash{2..5}

# create a dictionary
my %dic0 = ( 'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5, );

# % sigil prints out dictionary key and value
say Dumper %dic0{ 'a', 'b' };
say Dumper %dic0{ 'b' .. 'd' };

# @ sigil prints out dictionary key only
say Dumper @dic0{ 'a', 'b' };
say Dumper @dic0{ 'b' .. 'd' };
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
say join " ",               @dic2{ 'c', 'e' };
say join " ",               @dic2{ 'c' .. 'e' };

# get keys and values from dictionary / hash
my @arr13 = keys %dic2;
say "arr13 = " . join " ", @arr13;
my @arr14 = values %dic2;
say "arr14 = " . join " ", @arr14;

# dict to scalar context give size / length
say "length of dic2 = " . ( keys %dic2 );
my $key_exists = exists $dic2{"b"} ? "true" : "false";
say "\$dic2 key 'b' exists? " . $key_exists;

# 'exists' for dictionaries / hashes
$key_exists = exists $dic2{"z"} ? "true" : "false";
say "\$dic2 key 'z' exists? " . $key_exists;

# 'delete' for dictionaries / hashes
delete $dic2{'b'};

# 'each' for dictionaries (use while loop)
@print_temp = ();
while ( my ( $k, $v ) = each %dic2 ) {
    push @print_temp, "$k=>$v, ";
}
say "\%dic2 = " . join " ", @print_temp;
say "";

# references
my $num2  = 32;
my @arr15 = ( 100, 101, 102 );
my %dic3  = ( 'a' => 500, 'b' => 600, 'c' => 700 );

# dump values (prints only the values)
say Dumper ($num2);
say Dumper (@arr15);
say Dumper (%dic3);
say "";

# dump references to screen, use these to see how we can create references ourselves
say Dumper ( \$num2 );
say Dumper ( \@arr15 );
say Dumper ( \%dic3 );

# creating references based on dumper output to screen above
my $num_ref = \32;
my $arr_ref = [ 201, 202, 203 ];
my $dic_ref = {
    a => 5001,
    b => 5002,
    c => 5003
};
say Dumper($$num_ref);          # dereference scaler ref
say Dumper( $arr_ref->[0] );    # dereference element of array
say Dumper( $arr_ref->@* );     # dereference whole of array
say Dumper( $dic_ref->{a} );    # dereference element of dictionary
say Dumper( $dic_ref->%* );     # dereference whole of dictionary

# ME
# -- array / list
# create: @arrayList=()
# access: $arrayList[]
# create: $referenceArrayList=[]
# access: $referenceArrayList->[]
# -- dictionary / hash
# create: %dicHash=()
# access: $dicHash{}
# create: $referenceDicHash={}
# access: $referenceDicHash->{}

# creating multi layered references (hash ref with a hash ref with an array ref with a hash ref)
my $hash_ref = {
    'a' => 1,
    'b' => 2,

    # hash ref within hash ref
    'c' => {
        new  => 1,
        new2 => 2,

        # array ref within hash ref within hash ref
        deeply => [ 3, 4, { 'x' => "hi", 'y' => "bye" } ],
    },
};

# access multi layered references with arrow notation
# the point is we can nest HASH REFS and ARRAY REFS as deep as we want
say Dumper ($hash_ref);
say Dumper ( $hash_ref->{'c'}->{new2} );
say Dumper ( $hash_ref->{'c'}->{deeply}->[2]->{'y'} );

# find out the type of the reference via 'ref'
say Dumper ( ref $num_ref );
say Dumper ( ref $arr_ref );
say Dumper ( ref $hash_ref );

# get the all the keys from the entire (%*) hash ref
say Dumper ( keys $hash_ref->%* );

# get the all the values from the entire (@*) array ref
say Dumper ( $hash_ref->{'c'}->{deeply}->@* );

# delete nested array
delete $hash_ref->{'c'}->{deeply};
say Dumper ($hash_ref);

# delete nested hash
delete $hash_ref->{'c'};
say Dumper ($hash_ref);

sub pushy {

    # copy pointer / ref passed as argument
    my $arr_ptr = shift @_;

    # dereferencing the whole array and append a string
    push $arr_ptr->@*, "hello from pushy sub";
}

# subroutine with ref argument
my @arr16 = ( 7, 8, 9 );
say join " ", @arr16;
pushy( \@arr16 );
say join " ", @arr16;
say "";

# sub with parameters. set to default of undefined
sub my_params ($name = "Default Name") {
    say "hello " . $name;
}
my_params("Joe Bloggs");
my_params();
say"";

sub slurpy_catchall($name, @slurp) {
    say $name;
    # dumper print the reference declaration
    say Dumper \@slurp;
}
slurpy_catchall("John", 1, 2, {f=>"tea", g=>"coffee", h=>"sprite"});

# final expression is returned
1

1h30 done