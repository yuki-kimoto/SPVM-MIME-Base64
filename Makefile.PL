use 5.008_007;
use ExtUtils::MakeMaker;
use strict;
use warnings;
use Config;
use Getopt::Long 'GetOptions';

GetOptions(
  'meta' => \my $meta,
  'no-build-spvm-modules' => \my $no_build_spvm_modules,
);

if ($meta) {
  $no_build_spvm_modules = 1;
}

my %configure_and_runtime_requires = (
  'SPVM' => '0.986',
);

WriteMakefile(
  NAME              => 'SPVM::MIME::Base64',
  VERSION_FROM      => 'lib/SPVM/MIME/Base64.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
  PREREQ_PM         => {}, # e.g., Module::Name => 1.1
  ABSTRACT_FROM     => 'lib/SPVM/MIME/Base64.pm', # retrieve abstract from module
  AUTHOR            => 'Yuki Kimoto<kimoto.yuki@gmail.com>',
  LICENSE           => 'mit',
  NORECURS => 1,
  test => {TESTS => 't/*.t'},
  clean => {FILES => ".spvm_build"},
  META_MERGE => {
    'meta-spec' => { version => 2 },
    resources => {
      repository => {
        type => 'git',
        url  => 'https://github.com/yuki-kimoto/SPVM-MIME-Base64.git',
        web  => 'https://github.com/yuki-kimoto/SPVM-MIME-Base64',
      },
    },
    no_index => {
      directory => [],
    }
  },
  NORECURS => 1,
  CONFIGURE_REQUIRES => {
    %configure_and_runtime_requires,
  },
  PREREQ_PM         => {
    %configure_and_runtime_requires,
  },
  TEST_REQUIRES => {
    
  },
);
sub MY::postamble {
  
  my $make_rule = "";
  
  unless ($no_build_spvm_modules) {
    require SPVM::Builder::Util::API;
    # Native compile make rule
    $make_rule .= SPVM::Builder::Util::API::create_make_rule_native("MIME::Base64");

    # Native compile make rule
    $make_rule .= SPVM::Builder::Util::API::create_make_rule_native("MIME::QuotedPrint");
  }
  
  return $make_rule;
}
