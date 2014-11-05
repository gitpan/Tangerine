package Tangerine::hook::list;
{
  $Tangerine::hook::list::VERSION = '0.05';
}
use 5.010;
use strict;
use warnings;
use List::MoreUtils qw(any);
use Tangerine::HookData;
use Tangerine::Occurence;
use Tangerine::Utils qw(stripquotelike);

sub run {
    my $s = shift;
    if ((any { $s->[0] eq $_ } qw(use no)) && scalar(@$s) >= 3 &&
        (any { $s->[1] eq $_ } qw(aliased base parent))) {
        my ($version) = $s->[2] =~ /^(\d.*)$/o;
        $version //= '';
        my @args;
        if (scalar(@$s) > 3) {
            @args = @$s;
            @args = @args[($version ? 3 : 2) .. $#args-1];
            @args = grep { !/^-norequire$/ } @args
                if $s->[1] eq 'parent';
            @args = stripquotelike(@args);
        }
        return Tangerine::HookData->new(
            modules => {
                map {
                    ( $_ => Tangerine::Occurence->new(
                        version => $version,
                        ) )
                    } @args,
                },
            );
    }
    return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Tangerine::hook::list - Process simple module lists.

=head1 DESCRIPTION

This hook catches C<use> statements with modules loading more modules
listed as their arguments.

Currently this hook knows about L<aliased>, L<base> and L<parent>.

=head1 SEE ALSO

L<Tangerine>, L<aliased>, L<base>, L<parent>

=head1 AUTHOR

Petr Šabata <contyk@redhat.com>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2014 Petr Šabata

See LICENSE for licensing details.

=cut
