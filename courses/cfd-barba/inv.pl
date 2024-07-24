use strict;
use warnings;
use PDF::API2;
use PDF::API2::Basic::PDF::Utils;

my $pdf = PDF::API2->open('build/main.pdf');
for my $n (1..$pdf->pages()) {
    my $p = $pdf->openpage($n);

    $p->{Group} = PDFDict();
    $p->{Group}->{CS} = PDFName('DeviceRGB');
    $p->{Group}->{S} = PDFName('Transparency');

    my $gfx = $p->gfx(1);  # prepend
    $gfx->fillcolor('white');
    $gfx->rect($p->get_mediabox());
    $gfx->fill();

    $gfx = $p->gfx();  # append
    $gfx->egstate($pdf->egstate->blendmode('Difference'));
    $gfx->fillcolor('white');
    $gfx->rect($p->get_mediabox());
    $gfx->fill();
}
$pdf->saveas('out.pdf');
