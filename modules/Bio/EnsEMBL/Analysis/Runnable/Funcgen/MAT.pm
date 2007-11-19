# Ensembl module for Bio::EnsEMBL::Analysis::Runnable::Funcgen::MAT
#
# Copyright (c) 2007 Ensembl
#

=head1 NAME

Bio::EnsEMBL::Analysis::Runnable::Funcgen::MAT

=head1 SYNOPSIS

  my $runnable = Bio::EnsEMBL::Analysis::Runnable::Funcgen::MAT->new
  (
    -analysis => $analysis,
    -query => 'slice',
    -program => 'program.pl',
  );
  $runnable->run;
  my @features = @{$runnable->output};

=head1 DESCRIPTION

MAT expects to run the program MAT (Model-based Analysis of Tiling-array, Johnson 
et al., PMID: 16895995) and predicts features which can be stored in the 
annotated_feature table in the eFG database

=head1 LICENCE

This code is distributed under an Apache style licence. Please see
http://www.ensembl.org/info/about/code_licence.html for details.

=head1 AUTHOR

Stefan Graf, Ensembl Functional Genomics - http://www.ensembl.org

=head1 CONTACT

Post questions to the Ensembl development list: ensembl-dev@ebi.ac.uk

=cut

package Bio::EnsEMBL::Analysis::Runnable::Funcgen::MAT;

use strict;
use warnings;
use Data::Dumper;

use Bio::EnsEMBL::Analysis::Runnable;
use Bio::EnsEMBL::Analysis::Runnable::Funcgen;

use Bio::EnsEMBL::Utils::Exception qw(throw warning);
use Bio::EnsEMBL::Utils::Argument qw( rearrange );

use vars qw(@ISA);
@ISA = qw(Bio::EnsEMBL::Analysis::Runnable::Funcgen);

=head2 new

  Arg         : 
  Usage       : my $runnable = Bio::EnsEMBL::Analysis::Runnable::Funcgen->new()
  Description : Instantiates new Chipotle runnable
  Returns     : Bio::EnsEMBL::Analysis::Runnable::Funcgen::Nessie object
  Exceptions  : none

=cut

sub new {

    my ($class,@args) = @_;
    #print Dumper @args;
	my $self = bless {},$class;
    #print Dumper $self;

    #my ($result_features) = rearrange(['RESULT_FEATURES'], @args);
    #$self->result_features($result_features);
    #print Dumper($self->features);

    #print Dumper $self;
    return $self;

}




=head2 write_infile

    Arg [1]     : Bio::EnsEMBL::Analysis::Runnable::MAT
    Arg [2]     : filename
    Description : 
    Returntype  : 
    Exceptions  : 
    Example     : 

=cut

sub write_infile {
	
	my ($self, $filename) = @_;

	if (! $filename) {
		$filename = $self->infile();
	}

}

=head2 run_analysis

  Arg [1]     : Bio::EnsEMBL::Analysis::Runnable::MAT
  Arg [2]     : string, program name
  Usage       : 
  Description : 
  Returns     : 
  Exceptions  : 

=cut

sub run_analysis {
        
    my ($self, $program) = @_;
    
    if(!$program){
        $program = $self->program;
    }
    throw($program." is not executable ACME::run_analysis ") 
        unless($program && -x $program);

    my $command = $self->program . ' ' . $self->analysis->parameters;
    
    warn("Running analysis " . $command . "\n");
    
    #eval { system($command) };
    throw("FAILED to run $command: ", $@) if ($@);

}

=head2 infile

  Arg [1]     : Bio::EnsEMBL::Analysis::Runnable::MAT
  Arg [2]     : filename (string)
  Description : will hold a given filename or if one is requested but none
  defined it will use the create_filename method to create a filename
  Returntype  : string, filename
  Exceptions  : none
  Example     : 

=cut


sub infile{

  my ($self, $filename) = @_;

  if($filename){
    $self->{'infile'} = $filename;
  }
  if(!$self->{'infile'}){
    $self->{'infile'} = $self->create_filename($self->analysis->logic_name, 'dat');
  }

  return $self->{'infile'};

}


sub config_file {
    my $self = shift;
    $self->{'config_file'} = shift if(@_);
    return $self->{'config_file'};
}

1;
