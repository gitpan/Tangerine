package Tangerine::hook::testloading;
{
  $Tangerine::hook::testloading::VERSION = '0.11';
}
use strict;
use warnings;
use List::MoreUtils qw/any/;
use Mo;
use Tangerine::HookData;
use Tangerine::Occurence;
use Tangerine::Utils qw(stripquotelike);

extends 'Tangerine::Hook';

sub run {
    my ($self, $s) = @_;
    if (scalar(@$s) > 1 && any { $s->[0] eq $_ } qw/require_ok syntax_ok use_ok/) {
        return if $s->[1] eq ';';
        my @modules = stripquotelike((@$s)[1..$#$s]);
        return Tangerine::HookData->new(
            children => [ 
                    ($s->[0] eq 'require_ok' ?
                        ('require', $modules[0]) :
                        ('use', @modules)
                    )

                ],
            );
    }
    return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Tangerine::hook::testloading - Process various test-suite module loading
statements.

=head1 DESCRIPTION

Detect <use_ok()> and <require_ok()> subroutine calls.  This is
C<require>-style dependency.

=head1 SEE ALSO

L<Tangerine>, L<Tangerine::hook::tests>

=head1 AUTHOR

Petr Šabata <contyk@redhat.com>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2014 Petr Šabata

See LICENSE for licensing details.

=cut
