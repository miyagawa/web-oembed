use inc::Module::Install;
name 'Web-oEmbed';
all_from 'lib/Web/oEmbed.pm';

requires 'Moo';
requires 'Types::Standard';
requires 'LWP';
requires 'XML::LibXML::Simple';
requires 'JSON::XS';
requires 'HTML::Element';

build_requires 'Test::More';
auto_include;
WriteAll;
