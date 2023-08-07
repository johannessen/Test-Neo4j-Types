#!perl
use strict;
use warnings;
use lib qw(lib);

use Test::More 0.88;
use Test::Neo4j::Types;

plan skip_all => 'Skipping Neo4j::Types::Generic::* tests - not available'
	unless eval {
		require Neo4j::Types::Generic::DateTime;
		require Neo4j::Types::Generic::Duration;
		return 1;
	};

plan tests => 4;


# These packages simply check the unreleased Neo4j::Types 2.00
# generic implementations, as far as they exist already.


neo4j_datetime_ok 'Neo4j::Types::Generic::DateTime', sub {
	my ($class, $params) = @_;
	Neo4j::Types::DateTime->new($params);
};

my $epoch_syntax_ok;
neo4j_datetime_ok 'Neo4j::Types::Generic::DateTime', sub {
	my ($class, $params) = @_;
	return Neo4j::Types::DateTime->new($params)
		unless defined $params->{days} && defined $params->{seconds};
	$epoch_syntax_ok++;
	my $epoch = $params->{days} * 86400 + $params->{seconds};
	my $tz = $params->{tz_name} // $params->{tz_offset};
	return Neo4j::Types::DateTime->new($epoch, $tz);
}, 'epoch syntax neo4j_datetime_ok';
ok $epoch_syntax_ok, 'epoch syntax ok';

neo4j_duration_ok 'Neo4j::Types::Generic::Duration', sub {
	my ($class, $params) = @_;
	Neo4j::Types::Duration->new($params);
};


done_testing;
