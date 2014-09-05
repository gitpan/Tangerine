
use strict;
use warnings;

use 5.016;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Analyse perl files and report module-related information",
  "AUTHOR" => "Petr \305\240abata <contyk\@redhat.com>",
  "BUILD_REQUIRES" => {
    "Test::More" => 0,
    "Test::Script" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Tangerine",
  "EXE_FILES" => [],
  "LICENSE" => "mit",
  "NAME" => "Tangerine",
  "PREREQ_PM" => {
    "Exporter" => 0,
    "File::Find::Rule" => 0,
    "File::Find::Rule::Perl" => 0,
    "Getopt::Long" => 0,
    "List::MoreUtils" => 0,
    "Mo" => 0,
    "Mo::default" => 0,
    "PPI" => 0,
    "strict" => 0,
    "utf8" => 0,
    "version" => "0.77",
    "warnings" => 0
  },
  "VERSION" => "0.02",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



