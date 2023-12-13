# review of FCC Perl Programming Course 4h10m given by Youtube user @PerlTechStack (Valters Krupskis)

# need to install the following modules
# cpanm Path::Tiny
# cpanm JSON::XS

# if straberry perl installed (and in path), don't include the shebang (#!/usr/local/bin/perl -w)
# Surpress 5.8.0 warning: Powershell as admin: [Environment]::SetEnvironmentVariable("LC_ALL", "C")

# powershell warning fix: $env:LC_ALL='C'

use warnings;
use strict;
use feature qw /say/;

# begin block logic implemented before the following use statements
# n.b use statements also use BEGIN BLOCKS behind the scenes, make
# sure our begin block is before their begin block by pushing our
# path into the include array / list
BEGIN {
    push @INC, 'C:\Users\toepo\local\git-weebucket\perl-hello';
    push @INC, './'
}
use Dog;

# OOP
# perl's out of the box OOP can be improved upon using the Mouse module.
# -> invokes classname as hidden first argument
my $Doggy = Dog->new( "labrador", 50, 70, "golden", "fido" );
say $Doggy->get_breed();
say $Doggy->get_height();
$Doggy->set_breed("dalmation");
$Doggy->set_height(120);
say $Doggy->get_breed();
say $Doggy->get_height();
$Doggy->print_info();
say "";

# AddModule has used Exporter's import() and pushed to @EXPORT
use AddModule;
say "adding numbers using sub from AddModule: " . add_nums( 3, 2 );

# MultModule hasn't used Exporter's import() nor pushed to @EXPORT so
# use :: to represent full pathname
use MultModule;
say "multiply numbers using sub from MultModule: "
  . MultModule::mult_nums( 3, 2 );
say "";

# behind the scenes, this'll expand to:
# BEGIN {require 'Dog.pm'; Data::Dumper->import(); }
# by default Data::Dumper->import() will import all subs
# use can import modules, not perl files (require perl files)

# meta::cpan
# cpanm is better than cpan (can install cpanm using cpan!)
# install via: $> cpanm JSON::XS
use JSON::XS;

# encode perl hash as json
say "JSON moduleconvert perl hash and json:";
my $perl_hash_ref = { a => 2, b => 200, };
my $json_text     = encode_json($perl_hash_ref);
say $json_text;
my $perl_has_ref = decode_json($json_text);
say Dumper($perl_hash_ref);
say "";

# dumper great for debugging and seeing how to
# manually create array and hash REFERENCES
use Data::Dumper;

# signatures for subroutines (became non-experimental in perl 5.36)
use feature qw <signatures>;

# use is executed at compile time (via BEGIN blocks) and require is executed at run time
# require can be implemented conditionally where use cannot be implemented conditionally

# file handling with Path::Tiny module
# install: cpanm Path::Tiny;
# has many file/folder subs for read/write, permissions
# copy, move, working with different paths, etc
use Path::Tiny;
my $Path = path("./file-test1.txt");

# spew to file (Path::Tiny)
my @spewcontent = ( "line1\n", "line2\n", "line3\n", );
$Path->spew(@spewcontent);

# slurp from file into a sinle string (Path::Tiny)
my $slurpcontent = $Path->slurp;
say "Path slurp into scalar from file-test1: ";
say $slurpcontent;

# lines read from file one at a time (Path::Tiny)
my @linescontent = $Path->lines;
say "Path lines into array from file-test1: ";
map { print $_ } @linescontent;
say "";

# file handling (out of the box)
# > write, >> append, < read
open( my $FOUT, ">", "file-test2.txt" )
  or die "could not open file for writing: $!";
print $FOUT "hello there my friend";
print $FOUT "hope all is well with you";
print $FOUT "i'm doing some perl for fun";
close $FOUT;

# perl out of the box file io
# <> diamond operator reads a lines at a time
my @lines = ();
open( my $FIN, "<", "file-test2.txt" )
  or die "could not open file for reading: $!";
while ( defined( my $line = <$FIN> ) ) {
    chomp $line;
    push( @lines, $line );
}
say 'reading from file-test2 one line at a time via <$FIN> and chomping:';
say join "\n", @lines;
say "";

# STRING BASICS
# strings: qq{""} are interpolated, q{''} are literals
my $num1 = 7;
my $str1 = "Interpreted Double Quotes: Hello, World. The number is $num1!";
my $str2 =
  "Literal Double Quotes with Escape: Hello, World. The number is \$num!";
my $str_literal = 'Literal Single Quotes: Hello, World. The number is $num!';
say $str1;
say $str2;
say $str_literal;
say "";

# USER INPUT. The diamond variable <> returns a line from current input source
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

# ARRAYS
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

# QUOTATION OPERATORS
# q 'single quotes', qq "double quotes", qx `system quote`, qw word quote, qr regex quote,
# returns array / list splitting on whitespace & wrapping in 'single quotes'
# a quick way to specify a lot of little single-quoted words without the quotes
# splits into array / list on whitespace
# delimiters q, qq, qx, qw, qr: open close delimiters have to be: (), [], {} or <>
# delimiters q, qq, qx, qw, qr: other delimiters have to be the same:
# //, \\, !!, ||, .., ~~, $$, ,,, ??, ``, '', "", ;;, ::, ==, ++, --, **, %%, && or ^^
my @qw1 = qw (101 202 303 parenthesisDelimiters);
say Dumper @qw1;
say $qw1[1];
say "";
my @qw2 = qw [1001 squareBracketDelimiters       3333];
say Dumper @qw2;
@qw2 = qw < free code camp >;
say Dumper @qw2;
@qw2 = qw { radio free europe };
say Dumper @qw2;
my @qw3 = qw / fwdSlashDelimiters 999      xxrr/;
say Dumper @qw3;
say join ": ", qw /Hello Number 1/;
say "";

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

# PASS BY VALUE PASS BY REFERENCE TO SUB
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

# ARRAYS / LISTS
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

# DICTIONARIES / HASHES
# create a dictionary
my %dic0 = ( 'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5, );

# % sigil prints out dictionary key and value
say Dumper %dic0{ 'a', 'b' };
say Dumper %dic0{ 'b' .. 'd' };

# @ sigil prints out dictionary key only
say Dumper @dic0{ 'a', 'b' };
say Dumper @dic0{ 'b' .. 'd' };
say "";

# PUSH, POP, SHIFT, UNSHIFT ARRAY
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

# SORTING
# sorting (perl sorts ALPHABETICALLY by default, like JS)
my @arr9 = qw/h d e k t s/;
say "\@arr9 = " . join " ", @arr9;
my @arr10 = sort @arr9;
say "\@arr10 = " . join " ", @arr10;

my @arr11 = ( 4, 7, 8, 2, 3, 11 );
say "\@arr11 = " . join " ", @arr11;

# use block and spaceship to sort NUMBERS (since sort defaults to alphanumeric sorting)
my @arr12 = sort { $a <=> $b } @arr11;
say "\@arr12 = " . join " ", @arr12;
say "";

# DICTIONARIES / HASHES
# unordered in perl, keys are unique
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

# REFERENCES / POINTERS
my $num2  = 32;
my @arr15 = ( 100, 101, 102 );
my %dic3  = ( 'a' => 500, 'b' => 600, 'c' => 700 );

# dump values (prints only the values)
say Dumper ($num2);
say Dumper (@arr15);
say Dumper (%dic3);
say "";

# dump references to screen, use these to see how we can create references ourselves
# using dumper also makes it more readible
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

# -- array / list
# create: @arrayList=()             -> array syntax
# access: $arrayList[]
# create: $referenceArrayList=[]    -> array ref syntax
# access: $referenceArrayList->[]
# -- dictionary / hash
# create: %dicHash=()               -> hash syntax
# access: $dicHash{}
# create: $referenceDicHash={}      -> hash ref syntax
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

# sub with parameters (experimental). set to default of undefined
sub my_params ( $name = "Default Name" ) {
    say "hello " . $name;
}
my_params("Joe Bloggs");
my_params();
say "";

sub slurpy_catchall ( $name, @slurp ) {
    say $name;

    # dumper print the reference declaration (more readible)
    say Dumper \@slurp;
}
slurpy_catchall( "John", 1, 2, { f => "tea", g => "coffee", h => "sprite" } );

# ERROR HANDLING
# perl's out of the box solution using eval and die better solutions using
# Try::Tiny::SmartCatch or Exception::Class eval (try), or do (catch)
# and die (throws exception stored in special var $@).
sub pop_clogs {
    warn qq @warn: call an ambulance, I'm ill@;

    # die returns 0 (falsey) & throws exception with a message
    die qq ^I told you I was ill^;
}
eval {
    # die from function (return 0) or return 1
    my $ret = pop_clogs();
    1;
} or do {
    my $err = $@ || "that didn't end well";
    say qq{error: $err};
};

# will give message: "Died at hello.pl line 429"
# eval {
#     chdir "c:/users/hansolo/fakedir/";
# } or die;
# will give message: "No such file or directory at hello.pl line 434"
# eval {
#     chdir "c:/users/hansolo/fakedir/";
# } or die($!);

# TRUTHY / FALSEY
my $test_val = 1;
say $test_val ? "$test_val is true" : "$test_val is false";
$test_val = 0;
say $test_val ? "$test_val is true" : "$test_val is false";
$test_val = '1';
say $test_val ? "'$test_val' is true" : "'$test_val' is false";
$test_val = '0';    # oddity. string value "0" is falsey in perl
say $test_val ? "'$test_val' is true" : "'$test_val' is false";

# OPERATORS
# spaceship (3 way operator, returns 1, 0 or -1)
# left biggest = 1
# equal = 0
# right biggest -1
my $ufo = -5;
say $ufo <=> -53;

# strings use eq, ne, ne, gt, lt, ge, le for comparisons
my $str7 = "a";
my $str8 = "b";
print("$str7 eq $str8 = ");
say( 0 + ( $str7 eq $str8 ) );
print("$str7 ne $str8 = ");
say( 0 + ( $str7 ne $str8 ) );
print("$str7 gt $str8 = ");
say( 0 + ( $str7 gt $str8 ) );
print("$str7 lt $str8 = ");
say( 0 + ( $str7 lt $str8 ) );
print("$str7 ge $str8 = ");
say( 0 + ( $str7 ge $str8 ) );
print("$str7 le $str8 = ");
say( 0 + ( $str7 le $str8 ) );

# copy string using x ('multiplication' operator on strings)
say( "h " x 6 );
say "";

# CONTROL FLOW
unless ( 0 > 1 ) {
    say "unless means 'if not true': 0 > 1";
}
if ( !0 ) {
    say "if not true: !0";
}
my $num3 = 0;

# unless is INVERSE if statement
$num3 = 3 unless 1 > 2;
say("num3 = $num3");

my $if_val = 5;
if ( $if_val < 2 ) {
    say "if statement: if";
}
elsif ( $if_val == 5 ) {
    say "if statement: elsif";
}
else {
    say "if statement: else";
}
say "";

my $num4 = 3;
say "while loop";
while ( $num4 > 0 ) {
    say $num4--;
}
say "";

say "---for loop bare";
my @arr17 = ( "hi", "bye", "ciao", "bonjour", "hola", 6 .. 10 );
for (@arr17) {
    print "$_\n";
}

say "---foreach loop bare";
foreach (@arr17) {
    print "$_\n";
}

say "---for loop indexing";
for my $element (@arr17) {
    print "$element\n";
}

say "---for loop C-style";
for ( my $i = 0 ; $i < ( 0 + @arr17 ) ; ++$i ) {
    print "$arr17[$i]\n";
}
say "";

# next = continue in other languages
# last = break in other loops
# redo = no equivalent in other languages (redo current iteration)
# goto keyword. LOOP1: location. goto LOOP1;

# REGEX
# Very easy to use regex in perl, baked into the language, not an additional library
# =~ check for regex match
# !~ check for not regex match
my $test_text = "This is the first sentence. Red lorry. There are 2 dogs.";

# capture one (match) by if statement
my $pattern_capture_match1_a;
$pattern_capture_match1_a = $1 if ( $test_text =~ m/(\sRed\s\w{5})/ );
say( "pattern_capture_match1_a = " . $pattern_capture_match1_a );

# capture one (match) by destructuring / unpacking
my ($pattern_capture_match1_b) = $test_text =~ m/(\w{8}\.\sRed\s\w{5})/;
say( "pattern_capture_match1_b = " . $pattern_capture_match1_b );

# capture two (matches) by destructuring (using a single "my" to declare two variables)
my ( $pattern_capture_match2_a, $pattern_capture_match2_b ) =
  $test_text =~ m/(\sRed\s\w{5})\.(\sThere)/;
say( "pattern_capture_match2_a = " . $pattern_capture_match2_a );
say( "pattern_capture_match2_b = " . $pattern_capture_match2_b );

# capture three (matches) by if statement and destructuring
if ( $test_text =~ m/(This\s).*(\sRed\s\w{5})\.(\sThere)/ ) {
    my ( $pattern_capture_match3_a, $pattern_capture_match3_b,
        $pattern_capture_match3_c )
      = ( $1, $2, $3 );
    say( "pattern_capture_match3_a= " . $pattern_capture_match3_a );
    say( "pattern_capture_match3_b= " . $pattern_capture_match3_b );
    say( "pattern_capture_match3_c= " . $pattern_capture_match3_c );
}

# capture all matches into an array by destructuring (globally match 'The', case insensitive)
my (@pattern_capture_array1) = $test_text =~ m/The/gi;
say "pattern_capture_array1 = " . join ", ", @pattern_capture_array1;

# capture all matches into an array by destructuring (with word boundaries, character set, etc)
my (@pattern_capture_array2) =
  $test_text =~ m/(\Bentenc\B).*(\bRed\b).*(\d\sdo[cg]s)/gi;
say "pattern_capture_array2 = " . join ", ", @pattern_capture_array2;
say "";

# qr/STRING/ quotes its string to a regex (put regex into a variable)
$test_text = "Hello there. Another test sentence. I wish my car is a Porsche";
my $my_regex = qr/Ello.*por.{4}$/i;
say $test_text =~ $my_regex ? "\$my_regex matches" : "\$my_regex no match";
say "";

# print first two alphanumerics from each word in the array (list). minimalist TIMTOWTDI perl code
my @a = qw ? dog rat cat ?;
my $r = qr *^(\w{2})*;
foreach (@a) {
    say "$_ $1" unless $_ !~ $r;
}
my @captures1 = "";
my @captures2 = "";
foreach my $item (@a) {
    my ( $cap1, $cap2 ) = $item =~ /(\w)(\w)/;

    # capture using implicit in-built captures ($1, $2, $3, etc)
    push( @captures1, ("$1$2 ") );

    # capture into my variables
    push( @captures2, ("$cap1$cap2 ") );
}
say @captures1;
say @captures2;
say "";

# qr doesn't like full substitution regex, so do it piece by piece using array. minimalist TIMTOWTDI perl code
my @w = qw . og OG .;
foreach (@a) {

    # substitute without changing original $_ using /r modifier
    my $s1 = $_ =~ s/($w[0])/$w[1]/r;

   # substitute without changing original $_ via destructuring into new variable
    ( my $s2 = $_ ) =~ s/($w[0])/$w[1]/;
    say "$_ $s1 $s2";
}

# qx call `system command``
my $cmd = qx(dir);
say $cmd;

# dumping of normal collection and dumping of a reference to a collection
say("dumping normal hash");
my %hashy =
  ( "a" => "hey", b => "boy", 'c' => { d => "superstar", e => "dj" } );
say Dumper(%hashy);

# dumper shows six variables:
# $VAR1 ='a';
# $VAR2 = 'hey';
# $VAR3 = 'b';
# $VAR4 = "boy";
# $VAR5 = 'c';
# $VAR6 = {
#       'x' => 'superstar',
#       'd' => 'dj'
# };

# dumper shows one variable (the reference / pointer):
say("dumping reference to the hash");
say Dumper( \%hashy );

# $VAR1 = {
#           'a' => 'hey',
#           'b' => 'boy',
#           'c' => {
#                    'x' => 'superstar',
#                    'd' => 'dj'
#                  }
#         };

# use the single variable hash syntax from dumper to construct a hash pointer
my $emergency_addr = {
    w => "fireman",
    x => "policeman",
    y => "doctor",
};
say("hand-constructing emergency hash with an address scalar (ref / pointer)");
say($emergency_addr);
hash_doggify($emergency_addr);
say("dumping doggified emergency hash address scalar");
say Dumper ($emergency_addr);

sub hash_doggify {
    my $h_ptr = shift @_;
    $h_ptr->{"w"} .= " woof woof";
    $h_ptr->{x}   .= " woof woof";
    $h_ptr->{'y'} .= " grrrrr";
    return $h_ptr;
}
say("dumping doggified emergency hash address via full dereferencing ->%*");
say Dumper ( $emergency_addr->%* );

# built in functions: map
my @list1 = qw / cat dog rat /;
my @list2 = map {
    my $element = uc $_;
    $element .= "_new";

    # last expression returned
    $element
} @list1;

# note map doesn't change the items in place (copies all elements, adapts, new list)
say join " ", @list1;
say join " ", @list2;

# built in functions: grep
my @list3 = grep { $_ eq "cat" || /\Bog\b/ } @list1;
say join " ", @list3;
say "";

# built in functions: split and join
my $text_line = "this is my long line of text";

say $text_line;
my @split_arr = split( " ", $text_line );
map { say } @split_arr;
my @rejoined = join( "--", @split_arr );
say @rejoined;

say $text_line;
@split_arr = split( "", $text_line );
map { say } @split_arr;
@rejoined = join( "--", @split_arr );
say @rejoined;

say $text_line;
@split_arr = split( m/o/, $text_line );
map { say } @split_arr;
@rejoined = join( "--", @split_arr );
say @rejoined;

# built in functions: uc and lc (upper and lower case)
# create a list of words from $text_line, return first letter capitalised from each word via map
my @new = map { (/(^.)/); uc $1 } split( " ", $text_line );
say join " ", @new;
say "";

my @text_list = qw ? DINO HIPPO CROC KOMODO ?;
say @text_list;
my @text_list_title = map { lcfirst } @text_list;
say @text_list_title;
say "";

# built in functions: length, int, rand, sleep, substr, time
my $wee_text = "hey";
say length $wee_text;
say scalar(@text_list);
say int( rand(10) );
say "sleeping...";
sleep 1;
say "... awake now";

# start index 1, 2 chars
say substr( $wee_text, 1, 2 );

# epoch time in seconds (usually 19700101)
say time;

# special variables
say "process id: $$";
say "version of perl running this script: $]";
print "argument list passed to script: " . Dumper( \@ARGV );
print "include paths (absolute) for modules: " . Dumper( \@INC );
print "environment variables and their values: " . Dumper( \%ENV );

# read a line at a time from standard input STDIN via diamond variable
# while (<STDIN>) {say $_}
say "current script full path is: " . __FILE__;
say "number of lines in current script is: " . __LINE__;
say "number of lines in current script is: " . __LINE__;
say "current package: " . __PACKAGE__;
say "";

# running system commands:
# using qx and `backticks` (these are equivalent). return is STDOUT. command
# output not shown in STDOUT, it's returned, can be assigned to a perl variable.
for ( 0 .. 2 ) {
    if ($_ == 0) {
        my $stdout_echo = qx/echo $_......................./;
        say $stdout_echo;
        next;
    }
    my $stdout_dir = `ls *.pm`;
    say $stdout_dir;
    my $stdout_echo = qx/echo $_......................./;
    say $stdout_echo;
}

# running system commands:
# system command: return is exit status from command.
# command output is shown in STDOUT.
# my $exit_status = system( "gfind", ".", "-type", "f", "-iregex", ".+\.pl" );
my $exit_status = system( "ls *.pl" );
say "exit status: " . $exit_status;
# running system commands: exec (executes command then quits script!)
say "";
