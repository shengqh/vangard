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
  target_dir => "/scratch/ramiema/vangard/20171213_Hamid_599_RNAseq_human",

  #source files

files=> {
"SPH747_siRNA_599_LH_10"=>
["/scratch/vantage_repo/Vangard/599/599-LH-10_S2_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-10_S2_R2_001.fastq.gz"],

"SPH747_control_599_LH_11"=>
["/scratch/vantage_repo/Vangard/599/599-LH-11_S3_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-11_S3_R2_001.fastq.gz"],

"SPH747_siRNA_599_LH_12"=>
["/scratch/vantage_repo/Vangard/599/599-LH-12_S4_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-12_S4_R2_001.fastq.gz"],

"HFL1_control_599_LH_1"=>
["/scratch/vantage_repo/Vangard/599/599-LH-1_S1_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-1_S1_R2_001.fastq.gz"],

"HFL1_siRNA_599_LH_2"=>
["/scratch/vantage_repo/Vangard/599/599-LH-2_S2_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-2_S2_R2_001.fastq.gz"],

"HFL1_control_599_LH_3"=>
["/scratch/vantage_repo/Vangard/599/599-LH-3_S3_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-3_S3_R2_001.fastq.gz"],

"HFL1_siRNA_599_LH_4"=>
["/scratch/vantage_repo/Vangard/599/599-LH-4_S4_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-4_S4_R2_001.fastq.gz"],

"PPH173_control_599_LH_5"=>
["/scratch/vantage_repo/Vangard/599/599-LH-5_S5_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-5_S5_R2_001.fastq.gz"],

"PPH173_siRNA_599_LH_6"=>
["/scratch/vantage_repo/Vangard/599/599-LH-6_S6_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-6_S6_R2_001.fastq.gz"],

"PPH173_control_599_LH_7"=>
["/scratch/vantage_repo/Vangard/599/599-LH-7_S7_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-7_S7_R2_001.fastq.gz"],

"PPH173_siRNA_599_LH_8"=>
["/scratch/vantage_repo/Vangard/599/599-LH-8_S8_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-8_S8_R2_001.fastq.gz"],

"SPH747_control_599_LH_9"=>
["/scratch/vantage_repo/Vangard/599/599-LH-9_S1_R1_001.fastq.gz",
"/scratch/vantage_repo/Vangard/599/599-LH-9_S1_R2_001.fastq.gz"],
},

  #group information for visualization and comparison
  groups => {
    "HFL1_control" => ["HFL1_control_599_LH_1","HFL1_control_599_LH_3"],
    "HFL1_siRNA" => ["HFL1_siRNA_599_LH_2", "HFL1_siRNA_599_LH_4"],
    "PPH173_siRNA" => ["PPH173_siRNA_599_LH_6","PPH173_siRNA_599_LH_8"],
    "PPH173_control" => ["PPH173_control_599_LH_5","PPH173_control_599_LH_7"],
    "SPH747_siRNA" => ["SPH747_siRNA_599_LH_10", "SPH747_siRNA_599_LH_12"],
    "SPH747_control" => ["SPH747_control_599_LH_9","SPH747_control_599_LH_11"]
  },

  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
  pairs => {
    "HFL1_siRNA_vs_control" => [ "HFL1_siRNA", "HFL1_control" ],
    "PPH173_siRNA_vs_control" => ["PPH173_siRNA", "PPH173_control"],
    "SPH747_siRNA_vs_control" => ["SPH747_siRNA","SPH747_control"],

  },

  #perform enrichment analysis, organism should be: "athaliana" "btaurus"       "celegans"      "cfamiliaris"   "drerio"  "sscrofa"       "dmelanogaster" "ggallus"       "hsapiens"      "mmusculus"  "rnorvegicus"   "scerevisiae"
  perform_webgestalt => 1,
  webgestalt_organism => "hsapiens",
  
  #perform multiqc
   perform_multiqc => 1,
};
   
performRNASeq_gatk_b37($def);

1;
