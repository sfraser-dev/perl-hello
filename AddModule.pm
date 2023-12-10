package AddModule;

use strict;
use warnings;

# allow subs from this module to be imported by perl scripts via use command using two step process
# 1 add the import() sub to this package
use Exporter qw /import/;
# 2 add our subs to the EXPORT array / list
our @EXPORT = qw / add_nums /; 

sub add_nums {
    my $n1 = shift;
    my $n2 = shift;
    return $n1+$n2;
}

1