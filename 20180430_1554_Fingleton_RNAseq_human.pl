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
  target_dir => "/scratch/VANGARD/20180430_1554_Fingleton_RNAseq_human/result",

  #source files

files => {
  "Control_1" => ["/scratch/VANGARD/20180430_1554_Fingleton_RNAseq_human/1554/1554-BF-1-CGATGT_S1_R1_001.fastq.gz"],
  "Control_2" => ["/scratch/VANGARD/20180430_1554_Fingleton_RNAseq_human/1554/1554-BF-2-TTAGGC_S2_R1_001.fastq.gz"],
  "Stat6_Del_1" => ["/scratch/VANGARD/20180430_1554_Fingleton_RNAseq_human/1554/1554-BF-3-TGACCA_S3_R1_001.fastq.gz"],
  "Stat6_Del_2" => ["/scratch/VANGARD/20180430_1554_Fingleton_RNAseq_human/1554/1554-BF-4-ACAGTG_S4_R1_001.fastq.gz"],
  "Stat6_Act_1" => ["/scratch/VANGARD/20180430_1554_Fingleton_RNAseq_human/1554/1554-BF-5-GCCAAT_S5_R1_001.fastq.gz"],
  "Stat6_Act_2" => ["/scratch/VANGARD/20180430_1554_Fingleton_RNAseq_human/1554/1554-BF-6-CAGATC_S6_R1_001.fastq.gz"],
},

  #group information for visualization and comparison
 groups => {
    "Control" => ["Control_1", "Control_2"],
    "Stat6_Deletion" => ["Stat6_Del_1","Stat6_Del_2" ],
    "Stat6_Activation" => ["Stat6_Act_1", "Stat6_Act_2"],
  },
  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
  pairs => {
    "Stat6_Deletion_vs_Control" => ["Control" ,"Stat6_Deletion" ],
    "Stat6_Activation_vs_Control" => ["Control" , "Stat6_Activation"],
  },

#perform enrichment analysis, organism should be: "athaliana" "btaurus"       "celegans"      "cfamiliaris"   "drerio"  "sscrofa"       "dmelanogaster" "ggallus"       "hsapiens"      "mmusculus"  "rnorvegicus"   "scerevisiae"
 perform_webgestalt => 1,
 webgestalt_organism => "hsapiens",

 perform_multiqc => 1,
  
 perform_report => 1,
 

};

performRNASeq_gatk_b37($def);
1;
