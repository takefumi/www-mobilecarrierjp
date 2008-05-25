package WWW::MobileCarrierJP::ThirdForce::HTTPHeader;
use strict;
use warnings;
use utf8;
use WWW::MobileCarrierJP::Declare;

my @urls = map { sprintf 'http://creation.mb.softbank.jp/terminal/spec_head_%02d.html', $_ } 1..4;

parse_one(
    urls  => \@urls,
    xpath => '//div/table/tr/td/table[@bordercolor="#999999"]/tr[not(@bgcolor="#ee9abb") and not(@bgcolor="#cccccc") and count(child::td) = 8]',
    scraper => scraper {
        process 'td:nth-child(1)', 'model', 'TEXT';

        process 'td:nth-child(2)', 'x-jphone-name',    'TEXT';
        process 'td:nth-child(3)', 'x-jphone-display', 'TEXT';
        process 'td:nth-child(4)', 'x-jphone-color',   'TEXT';
        process 'td:nth-child(5)', 'x-jphone-sound', [ 'TEXT', \&_undefine, ];
        process 'td:nth-child(6)', 'x-jphone-smaf',  [ 'TEXT', \&_undefine, ];

        # maybe, no person needs x-s-* information.
        # and, I don't want to maintenance this header related things :P
        #   process 'td:nth-child(6)', 'x-s-display-info', [ 'TEXT', \&_undefine, ];
        #   process 'td:nth-child(7)', 'x-s-unique-id',    [ 'TEXT', \&_undefine, ];
    },
);

sub _undefine {
    my $x = shift;
    $x =~ /^(?:−|-)$/ ? undef : $x;
}

1;
__END__

=head1 NAME

WWW::MobileCarrierJP::ThirdForce::HTTPHeader - get HTTPHeader informtation from ThirdForce site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::ThirdForce::HTTPHeader;
    WWW::MobileCarrierJP::ThirdForce::HTTPHeader->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

