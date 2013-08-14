package reCaptcha_App;
use Moose;
use namespace::autoclean;
#use TestLogger;

use Catalyst::Runtime 5.90;

use Catalyst qw/
  ConfigLoader
/;

extends 'Catalyst';

our $VERSION = "0.01";
$VERSION = eval $VERSION;



__PACKAGE__->config(
  name => 'reCaptcha_App',
  disable_component_regex_fallback => 1,
);

#__PACKAGE__->log(TestLogger->new);

__PACKAGE__->setup;

