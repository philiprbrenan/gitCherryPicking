#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/
#-------------------------------------------------------------------------------
# Test cherry picking
# Philip R Brenan at appaapps dot com, Appa Apps Ltd Inc., 2022
#-------------------------------------------------------------------------------
use v5.30;
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Table::Text qw(:all);

=pod

Assume that we have the following set of git branches:

     main  -> E3
      |
     main2 -> A1

We want to apply just the changes made from main2 to a1 to e3 but no other
changes that were made between main and main2.

Solution:

  git checkout e3
  git cherry-pick main2..a1

=cut
my $home   = currentDirectory;                                                  # Home folder
my $git    = fpd $home, qw(git);                                                # Test git folder
my $file   = fpe $git,  qw(test txt);                                           # Test changes to this file
my $data   = <<END;
1 a
2 b
3 c
4 d
5 e
6 f
7 g
8 h
9 i
END

sub edit($$)                                                                    # Do an edit
 {my ($from, $to) = @_;                                                         # From string, to string
  my $d = readFile($file);
     $d =~ s($from) ($to)s;
  owf($file, $d);
 }

sub commit($)                                                                   # Commit a new branch
 {my ($branch) = @_;                                                            # Branch
  say STDERR qq(Commit $branch);
  say STDERR qx(cd $git; git add $file; git commit -m "$branch"; git status; cat test.txt);
 }

sub makeBranch($)                                                               # Create a new branch
 {my ($branch) = @_;                                                            # Branch
  say STDERR qq(Create $branch);
  say STDERR qx(cd $git; git checkout -b $branch; git status; cat test.txt);
 }

sub switchToBranch($)                                                           # Switch to an existing branch
 {my ($branch) = @_;                                                            # Branch
  say STDERR qq(Switch to $branch);
  say STDERR qx(cd $git; git checkout $branch; git status;  cat test.txt);
 }

sub title($)                                                                    # Print a title
 {my ($title) = @_;                                                             # Title
  say STDERR pad($title, 120, "_");
 }

title("Initialize git");
say STDERR qx(rm -rf $git);
makePath $git;
say STDERR qx(cd $git; git init);
say STDERR qx(cd $git; git config --global user.email "you\@example.com");
say STDERR qx(cd $git;  git config --global user.name "Your Name");
owf($file, $data);                                                              # Main

title("Create main");
makeBranch("main");
commit("main");

title("Create main->e3");
makeBranch("e3");
edit(q(a), q(a E3));
commit("e3");

title("Create main->main2");
switchToBranch("main");
edit(q(d), q(d main));
commit("main");

title("Create main2->a1");
makeBranch("a1");
edit(q(9 i), q(9 i a1));
commit("a1");

title("Apply main2->a1 to e3");
switchToBranch("e3");
say STDERR qx(cd $git; cat test.txt; git cherry-pick main..a1; cat test.txt);
commit("main");
