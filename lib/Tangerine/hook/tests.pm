package Tangerine::hook::tests;
{
  $Tangerine::hook::tests::VERSION = '0.10';
}
use 5.010;
use strict;
use warnings;
use List::MoreUtils qw(any);
use Mo;
use Tangerine::Hook;
use Tangerine::HookData;

extends 'Tangerine::Hook';

sub run {
    my ($self, $s) = @_;
    if ((any { $s->[0] eq $_ } qw(use no)) && scalar(@$s) > 1 &&
        (any { $s->[1] eq $_ }
            qw(Test::Inter Test::Modern Test::More Test::Strict))) {
        require Tangerine::hook::testloading;
        return Tangerine::HookData->new( hooks => [
                Tangerine::hook::testloading->new(type => 'req') ] );
    }
    return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Tangerine::hook::tests - Detect testing modules being loaded and
register additional hooks.

=head1 DESCRIPTION

This hook catches various testing modules and registers their specific
hooks, e.g. L<Tangerine::hook::testloading>.

Currently this hook knows about L<Test::Inter>, L<Test::Modern>, and L<Test::More>.

=head1 SEE ALSO

L<Tangerine>, L<Test::Inter>, L<Test::Modern>, L<Test::More>

=head1 AUTHOR

Petr Šabata <contyk@redhat.com>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2014 Petr Šabata

See LICENSE for licensing details.

=cut
