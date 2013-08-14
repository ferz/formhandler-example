use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$Bin/lib";
use Catalyst::Test 'reCaptcha_App';
use Test::More;

$DB::single=1;

my $expected = q(<script src="http://www.google.com/recaptcha/api/challenge?k=zio+pino" type="text/javascript"></script>);

content_like('/forgot_password', qr/$expected/, 'ok recaptcha');

done_testing;

1;