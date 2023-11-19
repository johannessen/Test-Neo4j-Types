use strict;
use warnings;


package Neo4j_Test::DateTime;
sub isa { $_[1] eq 'Neo4j::Types::DateTime' }

sub days { shift->[0] }
sub nanoseconds { shift->[1] }
sub seconds { shift->[2] }
sub tz_offset { shift->[4] }

sub tz_name {
	my $self = shift;
	if (! defined $self->[3] && defined $self->[4] && $self->[4] % 3600 == 0) {
		return 'Etc/GMT' if $self->[4] == 0;
		return sprintf 'Etc/GMT%+i', $self->[4] / -3600
			if $self->[4] <= 14*3600 && $self->[4] >= -12*3600;
	}
	return $self->[3];
}

sub epoch {
	my $self = shift;
	return ($self->days//0) * 86400 + ($self->seconds//0);
}

sub type {
	my $self = shift;
	my $days      = defined $self->days;
	my $seconds   = defined $self->seconds;
	my $tz_offset = defined $self->tz_offset;
	my $tz_name   = defined $self->tz_name;
	return 'DATE'
		if   $days && ! $seconds && ! $tz_offset && ! $tz_name;
	return 'LOCAL TIME'
		if ! $days &&   $seconds && ! $tz_offset && ! $tz_name;
	return 'ZONED TIME'
		if ! $days &&   $seconds &&   $tz_offset;
	return 'LOCAL DATETIME'
		if   $days &&   $seconds && ! $tz_offset && ! $tz_name;
	return 'ZONED DATETIME'
		if   $days &&   $seconds &&   ($tz_offset || $tz_name);
	die 'Type inconsistent';
}

sub new {
	my ($class, $params) = @_;
	bless [
		$params->{days},
		$params->{nanoseconds} // (defined $params->{seconds} ? 0 : undef),
		$params->{seconds} // (defined $params->{nanoseconds} ? 0 : undef),
		$params->{tz_name},
		$params->{tz_offset},
	], $class;
}


1;
