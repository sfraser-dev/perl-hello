use warnings;
use strict;
use feature qw/ say /;
use feature qw/ state /;

require "./scope2.pl";

# like "extern"
our ( $globby );

say $globby;

sub test {
    my $var = 0;
    $var += 1;
    say ">>>>>>>>>> " . $var; 
}

test();
test();
test();
test();
test();
say"";

sub test_static_state {
    state $var = 0;     # like a static variable
    $var++;
    say ">>>>>>>>>> " . $var; 
}

test_static_state();
test_static_state();
test_static_state();
test_static_state();
test_static_state();
say"";

sub test_my_static_map {
    # map isn't going to change, so make this hash ref static
    state $mappy = {
        a=>"hello",
        b=>"there",
        c=>"mister",
    };

    my $val_in = shift;
    say $mappy->{$val_in};
}


test_my_static_map("a");
test_my_static_map("b");
test_my_static_map("c");