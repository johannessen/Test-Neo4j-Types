#!perl
use strict;
use warnings;
use lib qw(lib);

use Test::More 0.88;
use Test::Neo4j::Types;

plan skip_all => 'Skipping Neo4j::Bolt::* tests - not available'
	unless eval { require Neo4j::Bolt; 1 };

plan tests => 3;


neo4j_node_ok 'Neo4j::Bolt::Node', sub { bless pop, shift };

neo4j_relationship_ok 'Neo4j::Bolt::Relationship', sub {
	my ($class, $params) = @_;
	return bless {
		%$params,
		start => $params->{start_id},
		end   => $params->{end_id},
	}, $class;
};

neo4j_path_ok 'Neo4j::Bolt::Path', sub { bless pop, shift };


done_testing;
