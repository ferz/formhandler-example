package reCaptcha_App::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

use reCaptcha_App::Form::ForgotPassword;

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

sub base : Chained('/') PathPart('') CaptureArgs(0) {
    my ( $self, $c ) = @_;
    # Common things here are to check for ACL and setup global contexts
}

sub forgot_password : PathPart("forgot_password") : Chained("/base") {
    my ($self, $c) = @_;
    $DB::single=1;
    $c->log->debug(sprintf("keys:\npublic: %s\nprivate: %s", $self->{reCaptcha_public_key}, $self->{reCaptcha_private_key}));
    $c->stash->{form}=reCaptcha_App::Form::ForgotPassword->new(
							 recaptcha_public_key=>$self->{reCaptcha_public_key}, 
							 recaptcha_private_key=>$self->{reCaptcha_private_key},
							); 

    if (! $c->stash->{form}->process(
				   params=>$c->req->body_parameters
				  )) {
	$c->response->body($c->stash->{form}->render);
	$c->detach;
    }
    ## it seems that user has submitted the email
    if (! $c->stash->{form}->validated) {
	# here the form has error messages in it
	$c->response->body($c->stash->{form}->render);
	$c->detach();
    }

    # do what you need to recover the user account,
    # for example send email to user with a token and a link to reset user password
    # then redirect to login form.

    $c->response->redirect('/login');
}


sub login : PathPart("login") : Chained("/base") {
    my ($self, $c) = @_;
    $c->response->body(q(Now login form...));
}

sub default : Chained('setup') PathPart('') Args() {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub end : Action {}

__PACKAGE__->meta->make_immutable;

1;
