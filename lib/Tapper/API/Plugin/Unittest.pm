package Tapper::API::Plugin::Unittest;

use warnings;
use strict;
use 5.010;

use Mojolicious::Lite;

put 'unit-test/:testrun' => sub {
        my $self = shift;
        $self->app->renderer->default_format('json');


        my $data;
        if ($self->tx->req->body) {
                require JSON::XS;
                $data = eval{JSON::XS::decode_json($self->tx->req->body)};
                if ($@) {
                        $self->render(json => {
                                               error => $@
                                              },
                                      status => 409,
                                     );
                        return;
                }
        }
        if (not $data->{foo} eq 'bar') {
                $self->render(json => {
                                       error => "Can not find key 'foo' with value 'bar' in JSON body",
                                      },
                              status => 409,
                             );
        }
        $self->respond_to(json => {json => {key => 'value'},
                                   status => 202,
                                  },
                         );
};

1;
