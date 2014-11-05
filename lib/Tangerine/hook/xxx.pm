package Tangerine::hook::xxx;
{
  $Tangerine::hook::xxx::VERSION = '0.10';
}
use 5.010;
use strict;
use warnings;
use List::MoreUtils qw(any);
use Mo;
use Tangerine::HookData;
use Tangerine::Occurence;
use Tangerine::Utils qw/stripquotelike/;

extends 'Tangerine::Hook';

sub run {
    my ($self, $s) = @_;
    my $defaultbackend = 'YAML';
    if ((any { $s->[0] eq $_ } qw(use no)) &&
        scalar(@$s) > 2 && $s->[1] eq 'XXX' && $self->type eq 'use') {
        my $module;
        if ($s->[2] eq '-dumper') {
            $module = 'Data::Dumper';
        } elsif ($s->[2] eq '-yaml') {
            $module = 'YAML';
        } elsif ($s->[2] eq '-with' && $s->[4]) {
            $module = stripquotelike($s->[4]);
        }
        $module //= $defaultbackend;
        return Tangerine::HookData->new( modules => {
                $module => Tangerine::Occurence->new } );
    } elsif ($s->[0] eq 'require' && $s->[1] eq 'XXX' && $self->type eq 'req') {
        return Tangerine::HookData->new( modules => {
                $defaultbackend => Tangerine::Occurence->new } );
    }
    return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Tangerine::hook::xxx - Detect L<XXX> module loading.

=head1 DESCRIPTION

This hook checks what parameters are passed to L<XXX> and loads additional
modules, if applicable.

=head1 SEE ALSO

L<Tangerine>, L<XXX>

=head1 AUTHOR

Petr Šabata <contyk@redhat.com>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2014 Petr Šabata

See LICENSE for licensing details.

=cut
