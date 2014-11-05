package Tangerine::hook::if;
{
  $Tangerine::hook::if::VERSION = '0.06';
}
use 5.010;
use strict;
use warnings;
use List::MoreUtils qw(any);
use Tangerine::HookData;
use Tangerine::Utils qw(stripquotelike);

sub run {
    my $s = shift;
    if ((any { $s->[0] eq $_ } qw(use no)) &&
        scalar(@$s) > 3 && $s->[1] eq 'if') {
        my ($version) = $s->[2] =~ /^(\d.*)$/o;
        $version //= '';
        my ($depth, $index) = (0, 1);
        for ($index = 2; $index < $#$s; $index++) {
            my $token = $s->[$index];
            $depth++ if ($token eq '[' || $token eq '{' || $token eq '(');
            $depth-- if ($token eq ']' || $token eq '}' || $token eq ')');
            last if ($token eq ';' || !$depth &&
                ($token eq ',' || $token eq '=>'));
        }
        $index++;
        if ($s->[$index]) {
            $s->[$index] = stripquotelike($s->[$index]);
            return Tangerine::HookData->new(
                children => [ $s->[0], @$s[$index..$#$s] ],
                );
        }
    }
    return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Tangerine::hook::if - Process C<use if> statements.

=head1 DESCRIPTION

This hook catches C<use if> statements, strips the condition and returns
the modified statement for further processing.

=head1 SEE ALSO

L<Tangerine>, L<if>

=head1 AUTHOR

Petr Šabata <contyk@redhat.com>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2014 Petr Šabata

See LICENSE for licensing details.

=cut
