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
  email => "marisol.a.ramirez\@vumc.org",

  #target dir which will be automatically created and used to save code and result
  target_dir => "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/result_cutadapt",

  #perform cutadapt
  perform_cutadapt => 1,
  cutadapt_option  => "-O 1",
  adapter          => "AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC",    #trueseq adapter
  adapter_5 => "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTA",
  min_read_length  => 30,
  
#source files
files => {
  "FLF_Nor_siRNA_A" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-1-TCTCGCGC-ATAGAGGC_S83_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-1-TCTCGCGC-ATAGAGGC_S83_R2_001.fastq.gz"],
  "FLF_Nor_siRNA_B" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-2-AGCGATAG-ATAGAGGC_S84_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-2-AGCGATAG-ATAGAGGC_S84_R2_001.fastq.gz"],
  "FLF_Nor_TBX4_A" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-3-TAATGCGC-CCTATCCT_S85_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-3-TAATGCGC-CCTATCCT_S85_R2_001.fastq.gz"],
  "FLF_Nor_TBX4_B" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-4-CGGCTATG-CCTATCCT_S86_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-4-CGGCTATG-CCTATCCT_S86_R2_001.fastq.gz"],
  "FLF_Hyp_siRNA_A" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-5-TCCGCGAA-CCTATCCT_S87_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-5-TCCGCGAA-CCTATCCT_S87_R2_001.fastq.gz"],
  "FLF_Hyp_siRNA_B" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-6-TCTCGCGC-CCTATCCT_S88_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-6-TCTCGCGC-CCTATCCT_S88_R2_001.fastq.gz"],
  "FLF_Hyp_TBX4_A" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-7-AGCGATAG-CCTATCCT_S89_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-7-AGCGATAG-CCTATCCT_S89_R2_001.fastq.gz"],
  "FLF_Hyp_TBX4_B" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-8-ATTCAGAA-CAGGACGT_S90_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-8-ATTCAGAA-CAGGACGT_S90_R2_001.fastq.gz"],
  "PPH173_Hyp_siRNA_A" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-9-GAATTCGT-CAGGACGT_S91_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-9-GAATTCGT-CAGGACGT_S91_R2_001.fastq.gz"],
  "PPH173_Hyp_siRNA_B" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-10-CTGAAGCT-CAGGACGT_S92_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-10-CTGAAGCT-CAGGACGT_S92_R2_001.fastq.gz"],
  "PPH173_Hyp_TBX4_A" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-11-TAATGCGC-CAGGACGT_S93_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-11-TAATGCGC-CAGGACGT_S93_R2_001.fastq.gz"],
  "PPH173_Hyp_TBX4_B" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-12-CGGCTATG-CAGGACGT_S94_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-12-CGGCTATG-CAGGACGT_S94_R2_001.fastq.gz"],
  "SPH747_Hyp_siRNA_A" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-13-TCCGCGAA-CAGGACGT_S95_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-13-TCCGCGAA-CAGGACGT_S95_R2_001.fastq.gz"],
  "SPH747_Hyp_siRNA_B" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-14-TCTCGCGC-CAGGACGT_S96_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-14-TCTCGCGC-CAGGACGT_S96_R2_001.fastq.gz"],
  "SPH747_Hyp_TBX4_A" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-15-AGCGATAG-CAGGACGT_S97_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-15-AGCGATAG-CAGGACGT_S97_R2_001.fastq.gz"],
  "SPH747_Hyp_TBX4_B" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-16-CTGAAGCT-GTACTGAC_S98_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-16-CTGAAGCT-GTACTGAC_S98_R2_001.fastq.gz"],
  "HFL1_Hyp_siRNA_A" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-17-TAATGCGC-GTACTGAC_S99_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-17-TAATGCGC-GTACTGAC_S99_R2_001.fastq.gz"],
  "HFL1_Hyp_TBX4_A" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-18-CGGCTATG-GTACTGAC_S100_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-18-CGGCTATG-GTACTGAC_S100_R2_001.fastq.gz"],
  "HFL1_Hyp_siRNA_B" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-19-TCCGCGAA-GTACTGAC_S101_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-19-TCCGCGAA-GTACTGAC_S101_R2_001.fastq.gz"],
  "HFL1_Hyp_TBX4_B" => ["/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-20-TCTCGCGC-GTACTGAC_S102_R1_001.fastq.gz", "/scratch/VANGARD/20180824_1796_Hamid_RNAseq_human/1796/1796-LH-20-TCTCGCGC-GTACTGAC_S102_R2_001.fastq.gz"],
},


  #group information for visualization and comparison
 groups => {
  "FLF_Nor_siRNA" => ["FLF_Nor_siRNA_A", "FLF_Nor_siRNA_B"],
  "FLF_Nor_TBX4"  => ["FLF_Nor_TBX4_A", "FLF_Nor_TBX4_B"],
  "FLF_Hyp_siRNA" => ["FLF_Hyp_siRNA_A", "FLF_Hyp_siRNA_B"],
  "FLF_Hyp_TBX4"  => ["FLF_Hyp_TBX4_A", "FLF_Hyp_TBX4_B"],
  "PPH173_Hyp_siRNA" => ["PPH173_Hyp_siRNA_A", "PPH173_Hyp_siRNA_B"],
  "PPH173_Hyp_TBX4"  => ["PPH173_Hyp_TBX4_A", "PPH173_Hyp_TBX4_B"],
  "SPH747_Hyp_siRNA" => ["SPH747_Hyp_siRNA_A", "SPH747_Hyp_siRNA_B"],
  "SPH747_Hyp_TBX4" => ["SPH747_Hyp_TBX4_A", "SPH747_Hyp_TBX4_B"],
  "HFL1_Hyp_siRNA"  => ["HFL1_Hyp_siRNA_A", "HFL1_Hyp_siRNA_B"],
  "HFL1_Hyp_TBX4"   => ["HFL1_Hyp_TBX4_A", "HFL1_Hyp_TBX4_B"],
  },

  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
 pairs => {
  "FLF_Nor_siRNA_vs_TBX4"	=> ["FLF_Nor_siRNA", "FLF_Nor_TBX4"],
  "FLF_Hyp_siRNA_vs_TBX4"	=> ["FLF_Hyp_siRNA", "FLF_Hyp_TBX4"],
  "PPH173_Hyp_siRNA_vs_TBX4"	=> ["PPH173_Hyp_siRNA", "PPH173_Hyp_TBX4"],
  "SPH747_Hyp_siRNA_vs_TBX4"	=> ["SPH747_Hyp_siRNA", "SPH747_Hyp_TBX4"],
  "HFL1_Hyp_siRNA_vs_TBX4"	=> ["HFL1_Hyp_siRNA", "HFL1_Hyp_TBX4"],
  },

#perform enrichment analysis, organism should be: "athaliana" "btaurus"       "celegans"      "cfamiliaris"   "drerio"  "sscrofa"       "dmelanogaster" "ggallus"       "hsapiens"      "mmusculus"  "rnorvegicus"   "scerevisiae"
 perform_webgestalt => 1,
 webgestalt_organism => "hsapiens",

 perform_multiqc => 1,
  
 perform_report => 1,
 

};

performRNASeq_gatk_b37($def);
1;
