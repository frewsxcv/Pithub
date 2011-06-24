package Pithub::GitData::Tags;

use Moose;
use Carp qw(croak);
use namespace::autoclean;
extends 'Pithub::Base';

=head1 NAME

Pithub::GitData::Tags

=head1 METHODS

=head2 create

=over

=item *

Create a Tag

    POST /repos/:user/:repo/git/tags

=back

Examples:

    $result = $p->git_data->tags->create( user => 'plu', repo => 'Pithub', data => { message => 'some message' } );

=cut

sub create {
    my ( $self, %args ) = @_;
    croak 'Missing key in parameters: data (hashref)' unless ref $args{data} eq 'HASH';
    $self->_validate_user_repo_args( \%args );
    return $self->request( POST => sprintf( '/repos/%s/%s/git/tags', $args{user}, $args{repo} ), $args{data} );
}

=head2 get

=over

=item *

Get a Tag

    GET /repos/:user/:repo/git/tags/:sha

=back

Examples:

    $result = $p->git_data->tags->get( user => 'plu', repo => 'Pithub', sha => 'df21b2660fb6' );

=cut

sub get {
    my ( $self, %args ) = @_;
    croak 'Missing key in parameters: sha' unless $args{sha};
    $self->_validate_user_repo_args( \%args );
    return $self->request( GET => sprintf( '/repos/%s/%s/git/tags/%s', $args{user}, $args{repo}, $args{sha} ) );
}

__PACKAGE__->meta->make_immutable;

1;
