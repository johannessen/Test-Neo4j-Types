use strict;
use warnings;


package Neo4j_Test::ByteArray;
sub isa { $_[1] eq 'Neo4j::Types::ByteArray' }

sub as_string {
	my $bytes = shift->[0];
	utf8::encode $bytes if utf8::is_utf8 $bytes;
	return $bytes;
}

sub new {
	my ($class, $params) = @_;
	bless [ $params->{as_string} ], $class;
}


1;
