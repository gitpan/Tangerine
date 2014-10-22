package Tangerine::HookData;
{
  $Tangerine::HookData::VERSION = '0.02';
}
use strict;
use warnings;
use Mo qw(default);

has hooks => [];
has modules => {};
has statement => undef;

1;

__END__

=pod

=encoding utf8

=head1 NAME

Tangerine::HookData - An envelope for data returned from a hook.

=head1 SYNOPSIS

    my $data = Tangerine::HookData->new(
        modules => {
            'ExtUtils::MakeMaker' => [
                Tangerine::Occurence->new(
                    line => 3,
                    version => '6.30'
                )
            ],
        },
        hooks => [
            Tangerine::Hook->new(
                type => 'use',
                run => \&Tangerine::hook::myhook::run
            )
        ],
        statement => [ qw/myhook_statement with_args ;/ ]
    );

=head1 DESCRIPTION

Hooks used this class to encapsulate their results before returning them
to the Tangerine object.

A hook may return a hash reference of module names pointing to lists of
L<Tangerine::Occurence> objects, a list reference of L<Tangerine::Hook>
objects that should be added to the list of hooks to run and a statement
which should be analysed in the context of the current line.

=head1 METHODS

=over

=item C<hooks>

Returns or sets a list reference of L<Tangerine::Hook> hooks to be run.

=item C<modules>

Returns or sets a hash reference of module names pointing to list
references of L<Tangerine::Occurence> objects.

=item C<statement>

Returns or sets the statement to be analysed.  This is a simple list
reference of significant children.  Tangerine statements are created
from L<PPI::Statement>'s C<schildren> method.

=back

=head1 SEE ALSO

L<Tangerine>, L<Tangerine::Hook>, L<Tangerine::Occurence>, L<PPI::Statement>

=head1 AUTHOR

Petr Šabata <contyk@redhat.com>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2014 Petr Šabata

See LICENSE for licensing details.

=cut
