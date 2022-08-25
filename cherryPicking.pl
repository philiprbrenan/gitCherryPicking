#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/
#-------------------------------------------------------------------------------
# Test cherry picking
# Philip R Brenan at appaapps dot com, Appa Apps Ltd Inc., 2022
#-------------------------------------------------------------------------------
use v5.30;
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);

=pod

     main  -> E3
      |
     main2 -> A1

Apply changes made to get from main2 to A1 without applying changes
made from main to main2

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

sub switchToBranch($)                                                           # Swicth to an existing branch
 {my ($branch) = @_;                                                            # Branch
  say STDERR qq(Switch to $branch);
  say STDERR qx(cd $git; git checkout $branch; git status;  cat test.txt);
 }

say STDERR qx(rm -rf $git);
makePath $git;
say STDERR qx(cd $git; git init);
owf($file, $data);                                                              # Main

makeBranch("main");
commit("main");

makeBranch("e3");
edit(q(a), q(a E3));
commit("e3");

switchToBranch("main");
edit(q(d), q(d main));
commit("main");

makeBranch("a1");
edit(q(9 i), q(9 i a1));
commit("a1");

switchToBranch("e3");
say STDERR qx(cd $git; cat test.txt; git cherry-pick main..a1; cat test.txt);
commit("main");
