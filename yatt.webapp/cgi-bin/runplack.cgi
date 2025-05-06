#!/usr/bin/perl -w
use strict;
use warnings FATAL => qw/all/;
use FindBin;
use lib "$FindBin::Bin/../lib", "$FindBin::Bin/../local/lib/perl5";

use File::Spec;

(my $app_root = File::Spec->rel2abs(__FILE__)) =~ s,/cgi-bin/[^/]+$,,;

use Plack::Runner;

my $plack_env = $ENV{PLACK_ENV} || 'deployment';
my $runner = Plack::Runner->new(
  env => $plack_env,
  app => "$app_root/app.psgi",
);

if (__FILE__ =~ /\.fcgi$/) {
  eval {
    require Plack::Handler::FCGI;
    require FCGI::ProcManager;
    my $server = Plack::Handler::FCGI->new(
      manager => FCGI::ProcManager->new(+{
        n_processes => 4,
      }),
      keep_stderr => 0,
    );
    $server->run($runner->locate_app->());
  };
  if ($@) {
    # 起動失敗時も、30秒以上はプロセスを生かしておく。そうしないと 600秒 BAN を食らうので
    my $sleep = 35;
    print STDERR "FCGI Startup failed, sleeping $sleep secs: $@\n";
    sleep $sleep;
  }
}
else {
  $runner->run();
}
