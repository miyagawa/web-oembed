use t::oEmbed;

plan skip_all => "inc/.author is not there" unless -e "inc/.author";
plan tests => 2 * blocks;

use Web::oEmbed;

my $consumer = Web::oEmbed->new;

my $providers = read_json("t/providers.json");
for my $provider (@$providers) {
    $consumer->register_provider($provider);
}

run {
    my $block = shift;

    my $res1 = $consumer->embed($block->input, { format => 'json' });
    my $res2 = $consumer->embed($block->input, { format => 'xml' });

    is $res1->url, $res2->url;
    is canon($res1->render), canon($block->html);
};

sub canon {
    use HTML::TreeBuilder;
    my $t = HTML::TreeBuilder->new;
    $t->parse(shift);
    return $t->as_HTML;
}

__END__
===
--- input: http://www.flickr.com/photos/bees/2362225867/
--- html: <a href="https://www.flickr.com/photos/bees/2362225867/" title="Bacon Lollys"><img alt="Bacon Lollys" height="768" src="https://farm4.staticflickr.com/3040/2362225867_4a87ab8baf_b.jpg" width="1024" /></a>

===
--- input: http://vimeo.com/191827734
--- html: <iframe allowfullscreen="allowfullscreen" frameborder="0" height="376" mozallowfullscreen="mozallowfullscreen" src="https://player.vimeo.com/video/191827734" title="The First Men" webkitallowfullscreen="webkitallowfullscreen" width="960"></iframe>
