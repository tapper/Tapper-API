package Mojolicious::Plugin::TapperConfig;

use Mojo::Base 'Mojolicious::Plugin';
use Tapper::Config;
# ABSTRACT: create config for Hypnotoad used in Tapper

=head1 SYNOPSIS
 
This module generates a config for the hypnotoad driving the Tapper::API
daemon. It will be integrated by telling Mojolicious to use this plugin.

 use Mojo::Base 'Mojolicious';

 sub startup
 {
     my ($self) = shift;
     $self->plugin('TapperConfig');
     ...
 }

=head1 FUNCTIONS

Register this plugin in the plugin system. Not supposed to be called
externally.

=cut


sub register {
  my ($self, $app) = @_;
  my $port = Tapper::Config->subconfig->{rest_api_port} || 3000;

  my $caller  =  lc((caller(2))[0]);
  $caller     =~ s/:+/_/;
  my $pid_file = Tapper::Config->subconfig->{paths}{workdir}."/$caller.pid";

  my $config = {hypnotoad => {listen => ["http://*:$port"], pid_file => $pid_file}};
  my $current = $app->defaults(config => $app->config)->config;
  %$current = (%$current, %$config);

  return $current;
}

1;
