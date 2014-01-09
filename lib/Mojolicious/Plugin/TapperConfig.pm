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

  my $config = {hypnotoad => {listen => ["http://*:$port"]}};
  my $current = $app->defaults(config => $app->config)->config;
  %$current = (%$current, %$config);

  return $current;
}

1;
