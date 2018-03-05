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
  target_dir => "/scratch/VANGARD/20180227_Fingleton_RNAseq_human/result_cutadapt2",

  #preprocessing
  pairend => 0, 

  #source files

files => {
  "BF1_control" => ["/scratch/VANGARD/20180227_Fingleton_RNAseq_human/1232-BF-1-ATTACTCG-AGGATAGG_S1_R1_001.fastq.gz"],
  "BF2_control" => ["/scratch/VANGARD/20180227_Fingleton_RNAseq_human/1232-BF-2-TCCGGAGA-AGGATAGG_S2_R1_001.fastq.gz"],
  "BF3_control" => ["/scratch/VANGARD/20180227_Fingleton_RNAseq_human/1232-BF-3-CGCTCATT-AGGATAGG_S3_R1_001.fastq.gz"],
  "BF1_24hr" => ["/scratch/VANGARD/20180227_Fingleton_RNAseq_human/1232-BF-4-GAGATTCC-AGGATAGG_S4_R1_001.fastq.gz"],
  "BF2_24hr" => ["/scratch/VANGARD/20180227_Fingleton_RNAseq_human/1232-BF-5-ATTCAGAA-AGGATAGG_S5_R1_001.fastq.gz"],
  "BF3_24hr" => ["/scratch/VANGARD/20180227_Fingleton_RNAseq_human/1232-BF-6-GAATTCGT-AGGATAGG_S6_R1_001.fastq.gz"],
  "BF1_48hr" => ["/scratch/VANGARD/20180227_Fingleton_RNAseq_human/1232-BF-7-CTGAAGCT-AGGATAGG_S7_R1_001.fastq.gz"],
  "BF2_48hr" => ["/scratch/VANGARD/20180227_Fingleton_RNAseq_human/1232-BF-8-TAATGCGC-AGGATAGG_S8_R1_001.fastq.gz"],
  "BF3_48hr" => ["/scratch/VANGARD/20180227_Fingleton_RNAseq_human/1232-BF-9-CGGCTATG-AGGATAGG_S9_R1_001.fastq.gz"],

},
  #group information for visualization and comparison
 groups => {
    "control" => ["BF1_control", "BF2_control", "BF3_control"],
    "tx_24hr" => ["BF1_24hr", "BF2_24hr" , "BF3_24hr"],
    "tx_48hr" => [ "BF1_48hr", "BF2_48hr", "BF3_48hr"],

  },
  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
  pairs => {
    "tx_24hr_vs_control" => [ "control", "tx_24hr"],
    "tx_48hr_vs_control" => [ "control", "tx_48hr"],
   
  },

#perform enrichment analysis, organism should be: "athaliana" "btaurus"       "celegans"      "cfamiliaris"   "drerio"  "sscrofa"       "dmelanogaster" "ggallus"       "hsapiens"      "mmusculus"  "rnorvegicus"   "scerevisiae"
 perform_webgestalt => 1,
 webgestalt_organism => "hsapiens",

 perform_multiqc => 1,
  
 perform_report => 1,
 

};

performRNASeq_gatk_b37($def);
1;
