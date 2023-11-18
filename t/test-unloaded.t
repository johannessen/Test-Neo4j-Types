#!perl
use strict;
use warnings;
use lib qw(lib t/lib);

use Test::Tester 0.08;
use Test::More 0.88;
use Test::Neo4j::Types;


# Verify that the test tools check that users loaded
# the module and properly report if they haven't.

my $diag = '';
{
	no warnings 'redefine';
	*Test::Neo4j::Types::diag = sub { $diag = shift };
}

check_test(
	sub { neo4j_node_ok 'Neo4j_Test::Node', sub {} },
	{ ok => 0, depth => undef }
);
is $diag, "Neo4j_Test::Node is not loaded", 'no node module diag';

check_test(
	sub { neo4j_relationship_ok 'Neo4j_Test::Rel', sub {} },
	{ ok => 0, depth => undef }
);
is $diag, "Neo4j_Test::Rel is not loaded", 'no relationship module diag';

check_test(
	sub { neo4j_path_ok 'Neo4j_Test::Path', sub {} },
	{ ok => 0, depth => undef }
);
is $diag, "Neo4j_Test::Path is not loaded", 'no path module diag';

check_test(
	sub { neo4j_point_ok 'Neo4j_Test::Point', sub {} },
	{ ok => 0, depth => undef }
);
is $diag, "Neo4j_Test::Point is not loaded", 'no point module diag';

check_test(
	sub { neo4j_datetime_ok 'Neo4j_Test::DateTime', sub {} },
	{ ok => 0, depth => undef }
);
is $diag, "Neo4j_Test::DateTime is not loaded", 'no datetime module diag';

check_test(
	sub { neo4j_duration_ok 'Neo4j_Test::Duration', sub {} },
	{ ok => 0, depth => undef }
);
is $diag, "Neo4j_Test::Duration is not loaded", 'no duration module diag';

check_test(
	sub { neo4j_bytearray_ok 'Neo4j_Test::ByteArray', sub {} },
	{ ok => 0, depth => undef }
);
is $diag, "Neo4j_Test::ByteArray is not loaded", 'no bytearray module diag';

done_testing;
