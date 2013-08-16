package reCaptcha_App::Form::ForgotPassword;

use HTML::FormHandler::I18N;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler'; # se non derivasse da DBIC

# include Bootstrap, ma con la prima centra i campi del form e non mi piace, almeno su desktop.
# with 'HTML::FormHandler::Widget::Theme::Bootstrap';
with 'HTML::FormHandler::Widget::Theme::BootstrapFormMessages';

#with 'HTML::FormHandlerX::Widget::Field::reCAPTCHA';  REMOVED, UNNEEDED - JNAP
use HTML::FormHandler::Types ('Email' );

our $VERSION = '0.01';

# has +$name 
# This is variation on the normal attribute creator "has" which
# allows you to clone and extend an attribute from a superclass or
# from a role.
#
has '+widget_wrapper' => ( default => 'Bootstrap' );
#has '+item_class' => ( default => 'Utenti' );
has '+is_html5' => (default=>1);

has ['recaptcha_public_key','recaptcha_private_key'] => (is => 'rw', isa=>'Str', required=>1);

has_field 'email' => (type => 'Email', 'label'=>'email', element_class=>'span4', required=>1);

has_field 'recaptcha' => (
        type=>'reCAPTCHA', 
        recaptcha_message => "You failed the human test!",
        required=>1,
);

has_field 'submit' => ( type => 'Submit', value => q(Send me email), element_class => ['btn', 'btn-primary'] );

no HTML::FormHandler::Moose;
1;
