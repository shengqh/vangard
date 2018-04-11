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
  target_dir => "/scratch/VANGARD/20180322_1182_Parekh_RNAseq_human/result_cutadapt",

  #preprocessing
  pairend => 1, 
  perform_cutadapt => 1,
  cutadapt_option  => "-O 1",
  adapter          => "AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC",    #trueseq adapter
  min_read_length  => 30,

  #source files

files => {
  "Adult_fib1" => ["/scratch/VANGARD/20180322_1182_Parekh_RNAseq_human/1182-AP-1-TCCGCGAA-CCTATCCT_S816_R1_001.fastq.gz", "/scratch/VANGARD/20180322_1182_Parekh_RNAseq_human/1182-AP-1-TCCGCGAA-CCTATCCT_S816_R2_001.fastq.gz"],
  "Adult_fib2" => ["/scratch/VANGARD/20180322_1182_Parekh_RNAseq_human/1182-AP-2-TCTCGCGC-CCTATCCT_S817_R1_001.fastq.gz", "/scratch/VANGARD/20180322_1182_Parekh_RNAseq_human/1182-AP-2-TCTCGCGC-CCTATCCT_S817_R2_001.fastq.gz"],
  "Fetal_fib1" => ["/scratch/VANGARD/20180322_1182_Parekh_RNAseq_human/1182-AP-3-AGCGATAG-CCTATCCT_S818_R1_001.fastq.gz", "/scratch/VANGARD/20180322_1182_Parekh_RNAseq_human/1182-AP-3-AGCGATAG-CCTATCCT_S818_R2_001.fastq.gz"],
  "Fetal_fib2" => ["/scratch/VANGARD/20180322_1182_Parekh_RNAseq_human/1182-AP-4-ATTACTCG-GGCTCTGA_S819_R1_001.fastq.gz", "/scratch/VANGARD/20180322_1182_Parekh_RNAseq_human/1182-AP-4-ATTACTCG-GGCTCTGA_S819_R2_001.fastq.gz"],

},
  #group information for visualization and comparison
 groups => {
    "Adult_fibroblast" => ["Adult_fib1", "Adult_fib2"],
    "Fetal_fibroblast" => ["Fetal_fib1", "Fetal_fib2"],

  },
  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
  pairs => {
    "Fetal_vs_Adult" => [ "Adult_fibroblast", "Fetal_fibroblast"],
   
  },

#perform enrichment analysis, organism should be: "athaliana" "btaurus"       "celegans"      "cfamiliaris"   "drerio"  "sscrofa"       "dmelanogaster" "ggallus"       "hsapiens"      "mmusculus"  "rnorvegicus"   "scerevisiae"
 perform_webgestalt => 1,
 webgestalt_organism => "hsapiens",

 perform_multiqc => 1,
  
 perform_report => 1,
 

};

performRNASeq_gatk_b37($def);
1;
