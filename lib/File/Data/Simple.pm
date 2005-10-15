package File::Data::Simple;
use strict;
use Carp;
use FileHandle;

our $VERSION = '0.01';

=head1 NAME

File::Data::Simple - Simple file r/w/a interface.

=head1 SYNOPSIS

  # read data
  my $data  = File::Data::Simple->read('./example.data');
  my @lines = File::Data::Simple->read('./example.txt');

  # or OOP way:
  my $f = File::Data::Simple->new;
  my $data = $f->read('./example.data');

  # write data
  File::Data::Simple->write('./exapmle.data', $data);

  # append data
  File::Data::Simple->append('./example.txt', $text);

=head1 DESCRIPTION

This module provides simple read and write file interfaces.

=head1 METHODS

=over 4

=item new

=cut

sub new { bless {}, shift }

=item read

=cut

sub read {
    my ( $self, $file ) = @_;
    croak q{require $file argument for read} unless $file;

    $self = __PACKAGE__->new if __PACKAGE__ eq $self;

    my $fh = $self->{_fh} ||= FileHandle->new;

    unless ($fh->open($file)) {
        croak qq{cannot open file: '$file'};
    }
    else {
        my $file = join q{}, <$fh>;
        $fh->close;

        return split /\r?\n\r?/, $file if wantarray;
        return $file;
    }
}

=item write

=cut

sub write {
    my ( $self, $file, $data ) = @_;
    croak q{require $file argument for read} unless $file;
    croak q{require $data argument for read} unless $data;

    $self = __PACKAGE__->new if __PACKAGE__ eq $self;
    my $fh = $self->{_fh} ||= FileHandle->new;

    unless ($fh->open("> $file")) {
        croak qq{cannot open file: '$file'};
    }

    print $fh $data;
    $fh->close;

    1;
}

=item append

=cut

sub append {
    my ( $self, $file, $data ) = @_;
    croak q{require $file argument for read} unless $file;
    croak q{require $data argument for read} unless $data;

    $self = __PACKAGE__->new if __PACKAGE__ eq $self;
    my $fh = $self->{_fh} ||= FileHandle->new;

    unless ($fh->open(">> $file")) {
        croak qq{cannot open file: '$file'};
    }

    print $fh $data;
    $fh->close;

    1;
}

=back

=head1 NOTE

If you call this module's function multiple times, OOP way has more performance.
Because OOP way reuse one FileHandle object created once.

=head1 SEE ALSO

L<File::Data>

=head1 AUTHOR

Daisuke Murase E<lt>typester@cpan.orgE<gt>

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

1;
