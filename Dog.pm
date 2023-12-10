package Dog;

# this is a package file aka classname

# objects in perl are glorified hash refs

# entity referenced by REF is now an object in the CLASSNAME package
# bless REF, CLASSNAME
# or the current package if CLASSNAME is omitted (two arguments best practice)
# bless REF
# blessing REF gives it access to all the subs in package CLASSNAME

# bless associates a reference with a package
# blessing allows special syntax to be applied to the reference

# $Doggy = Dog->new(@args)
# will call sub new() passing Dog silently as the first argument.
# scalar value $self is then blessed by the Dog package giving it access
# to all of its subroutines. scalar $self is then given to the $Doggy instance
# $Doggy->set_breed(@args)
# will call sub set_breed() passing instance $Doggy silently as
# the first argument then the rest of the @args. The sub set_breed()
# should be present in the package called Dog.

use strict;
use warnings;
use feature qw ^say^;
use Data::Dumper;

sub new {
    my ( $classname, $breed, $height, $weight, $color, $name ) = @_;

    say "nb: classname = $classname";

    # hash ref
    my $self = {
        breed  => $breed,
        height => $height,
        weight => $weight,
        color  => $color,
        name   => $name,
    };

    # bless our instance with the classname / package
    bless $self;

    return $self;
}

# getter
sub get_breed {

    # self is the blessed version of the class aka a hash
    # ref that calls key value pairs
    my $self = shift;
    return $self->{breed};
}

# getter
sub get_height {

    # the blessed self reference (self hash ref) used again
    my $self = shift;
    return $self->{height};
}

# setter
sub set_breed {
    my $self = shift;
    my $b    = shift;
    $self->{breed} = $b;
}

# setter
sub set_height {
    my $self = shift;
    my $h    = shift;
    $self->{height} = $h;
}

# method
sub print_info {
    my $self = shift;
    my $b    = $self->{breed};
    my $h    = $self->{height};
    my $w    = $self->{weight};
    my $n    = $self->{name};
    say "breed=$b, height=$h, weight=$w, name=$n";
}

sub DESTROY {
    # will get called by perl's garbage collector (~destructor)
    say "bye bye everyone";
}

1
