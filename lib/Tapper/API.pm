package Tapper::API;

# ABSTRACT: Tapper - REST frontend

use 5.010;
use strict;
use warnings;

use Mojo::Base 'Mojolicious';
use Tapper::Config;

sub startup {
        my $self = shift;

        my $cfg = Tapper::Config->subconfig;
        my $r = $self->routes;
        foreach my $target (@{$cfg->{api}->{routes}}) {
                $r->any($target->{url})->detour($target->{module});
        }
}

1; # End of Tapper::API
