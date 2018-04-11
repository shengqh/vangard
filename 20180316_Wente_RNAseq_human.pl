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
  task_name => "RNAseq_human",

  #email which will be used for notification if you run through cluster
  email => "marisol.a.ramirez\@vanderbilt.edu",

  #target dir which will be automatically created and used to save code and result
  target_dir => "/scratch/VANGARD/20180315_Wente_RNAseq_human/result",

  #preprocessing
  pairend => 1, 

  #source files

files => {
 "sample4" => ["/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-4_1_sequence.fastq.gz", "/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-4_2_sequence.fastq.gz"],
 "sample5" => ["/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-5_1_sequence.fastq.gz", "/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-5_2_sequence.fastq.gz"],
 "sample6" => ["/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-6_1_sequence.fastq.gz", "/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-6_2_sequence.fastq.gz"],
 "sample7" => ["/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-7_1_sequence.fastq.gz", "/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-7_2_sequence.fastq.gz"],
 "sample8" => ["/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-8_1_sequence.fastq.gz", "/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-8_2_sequence.fastq.gz"],
 "sample9" => ["/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-9_1_sequence.fastq.gz", "/scratch/VANGARD/20180315_Wente_RNAseq_human/3408-SRW-9_2_sequence.fastq.gz"],

},
  #group information for visualization and comparison
 groups => {
    "control" => ["sample4", "sample7"],
    "test" => ["sample5", "sample8"],

  },
  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
  pairs => {
    "test_vs_control" => [ "control", "test"],
   
  },

#perform enrichment analysis, organism should be: "athaliana" "btaurus"       "celegans"      "cfamiliaris"   "drerio"  "sscrofa"       "dmelanogaster" "ggallus"       "hsapiens"      "mmusculus"  "rnorvegicus"   "scerevisiae"
 perform_webgestalt => 1,
 webgestalt_organism => "hsapiens",

 perform_multiqc => 1,
  
 perform_report => 1,
 

};

performRNASeq_gatk_b37($def);
1;
