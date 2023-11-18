use strict;
use warnings;


package Neo4j_Test::Point;
sub DOES { $_[1] eq 'Neo4j::Types::Point' }

sub srid { shift->[1] }
sub coordinates { @{shift->[0]} }

sub new {
	my ($class, $params) = @_;
	bless [
		$params->{coordinates},
		$params->{srid},
	], $class;
}


1;
