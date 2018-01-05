#!/usr/bin/perl
use strict;
use warnings;

use CQS::ClassFactory;
use CQS::FileUtils;
use CQS::SystemUtils;
use CQS::ConfigUtils;
use CQS::PerformRNAseq;

my $def = {

  #define task name, this name will be used as prefix of a few result, such as read count table file name.
  task_name => "RNAseq_mouse",

  #email which will be used for notification if you run through cluster
  email => "baohong.liu\@vanderbilt.edu",

  #target dir which will be automatically created and used to save code and result
  target_dir => "/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/RNASeq_result",

  #source files
 files => {
  "983-LW-4" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-4-GAGATTCC-TATAGCCT_S388_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-4-GAGATTCC-TATAGCCT_S388_R2_001.fastq.gz"],
  "983-LW-5" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-5-ATTCAGAA-TATAGCCT_S389_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-5-ATTCAGAA-TATAGCCT_S389_R2_001.fastq.gz"],
  "983-LW-6" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-6-GAATTCGT-TATAGCCT_S390_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-6-GAATTCGT-TATAGCCT_S390_R2_001.fastq.gz"],
  "983-LW-7" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-7-CTGAAGCT-TATAGCCT_S391_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-7-CTGAAGCT-TATAGCCT_S391_R2_001.fastq.gz"],
  "983-LW-8" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-8-TAATGCGC-TATAGCCT_S392_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-8-TAATGCGC-TATAGCCT_S392_R2_001.fastq.gz"],
  "983-LW-9" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-9-CGGCTATG-TATAGCCT_S393_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-9-CGGCTATG-TATAGCCT_S393_R2_001.fastq.gz"],
  "983-LW-10" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-10-TCCGCGAA-TATAGCCT_S394_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-10-TCCGCGAA-TATAGCCT_S394_R2_001.fastq.gz"],
  "983-LW-11" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-11-TCTCGCGC-TATAGCCT_S395_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-11-TCTCGCGC-TATAGCCT_S395_R2_001.fastq.gz"],
  "983-LW-12" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-12-AGCGATAG-TATAGCCT_S396_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-12-AGCGATAG-TATAGCCT_S396_R2_001.fastq.gz"],
  "983-LW-13" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-13-ATTACTCG-ATAGAGGC_S397_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectB/983-LW-13-ATTACTCG-ATAGAGGC_S397_R2_001.fastq.gz"],
},
  #group information for visualization and comparison

  groups => {
    "knockout" => [ "983-LW-9","983-LW-10","983-LW-11","983-LW-12","983-LW-13" ],
    "control" => [ "983-LW-4","983-LW-5","983-LW-6","983-LW-7","983-LW-8" ],

  },

  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
  pairs => {
    "knockout_vs_control" => [ "control", "knockout" ],  
},
  
  perform_webgestalt => 1,
  webgestalt_organism => "mmusculus",

  #perform multiqc
    perform_multiqc => 1,
  


};

performRNASeq_gencode_mm10($def);

1;
