use strict;
use warnings;


package Neo4j_Test::Duration;
sub isa { $_[1] eq 'Neo4j::Types::Duration' }

sub months { shift->[0] }
sub days { shift->[1] }
sub seconds { shift->[2] }
sub nanoseconds { shift->[3] }

sub new {
	my ($class, $params) = @_;
	bless [
		$params->{months} // 0,
		$params->{days} // 0,
		$params->{seconds} // 0,
		$params->{nanoseconds} // 0,
	], $class;
}


1;
