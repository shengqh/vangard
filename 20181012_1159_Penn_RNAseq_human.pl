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
  target_dir => "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/result_cutadapt",

  #perform cutadapt
  perform_cutadapt => 1,
  cutadapt_option  => "-O 1",
  adapter          => "AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC",    #trueseq adapter
  adapter_5 => "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTA",
  min_read_length  => 30,
  
#source files
files => {
  "HMC_cntA_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-1-ATTACTCG-TATAGCCT_S11_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-1-ATTACTCG-TATAGCCT_S11_R2_001.fastq.gz"],
  "HMC_cntA_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-2-TCCGGAGA-TATAGCCT_S12_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-2-TCCGGAGA-TATAGCCT_S12_R2_001.fastq.gz"],
  "HMC_drugA_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-3-CGCTCATT-TATAGCCT_S13_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-3-CGCTCATT-TATAGCCT_S13_R2_001.fastq.gz"],
  "HMC_drugA_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-4-GAGATTCC-TATAGCCT_S14_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-4-GAGATTCC-TATAGCCT_S14_R2_001.fastq.gz"],

  "Astro_cntA_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-5-ATTCAGAA-TATAGCCT_S15_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-5-ATTCAGAA-TATAGCCT_S15_R2_001.fastq.gz"],
  "Astro_cntA_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-6-GAATTCGT-TATAGCCT_S16_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-6-GAATTCGT-TATAGCCT_S16_R2_001.fastq.gz"],
  "Astro_drugA_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-7-CTGAAGCT-TATAGCCT_S17_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-7-CTGAAGCT-TATAGCCT_S17_R2_001.fastq.gz"],
  "Astro_drugA_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-8-TAATGCGC-TATAGCCT_S18_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-8-TAATGCGC-TATAGCCT_S18_R2_001.fastq.gz"],

  "Mglia_cntA_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-9-CGGCTATG-TATAGCCT_S19_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-9-CGGCTATG-TATAGCCT_S19_R2_001.fastq.gz"],
 "Mglia_cntA_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-10-TCCGCGAA-TATAGCCT_S20_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-10-TCCGCGAA-TATAGCCT_S20_R2_001.fastq.gz"],
  "Mglia_drugA_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-11-TCTCGCGC-TATAGCCT_S21_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-11-TCTCGCGC-TATAGCCT_S21_R2_001.fastq.gz"],
  "Mglia_drugA_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-12-AGCGATAG-TATAGCCT_S22_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-12-AGCGATAG-TATAGCCT_S22_R2_001.fastq.gz"],

  "HMC_cntB_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-37-AGCGATAG-CCTATCCT_S46_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-37-AGCGATAG-CCTATCCT_S46_R2_001.fastq.gz"],
  "HMC_cntB_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-14-ATTACTCG-ATAGAGGC_S23_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-14-ATTACTCG-ATAGAGGC_S23_R2_001.fastq.gz"],
  "HMC_drugB_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-15-TCCGGAGA-ATAGAGGC_S24_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-15-TCCGGAGA-ATAGAGGC_S24_R2_001.fastq.gz"],
  "HMC_drugB_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-16-CGCTCATT-ATAGAGGC_S25_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-16-CGCTCATT-ATAGAGGC_S25_R2_001.fastq.gz"],
  
  "Astro_cntB_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-17-GAGATTCC-ATAGAGGC_S26_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-17-GAGATTCC-ATAGAGGC_S26_R2_001.fastq.gz"],
  "Astro_cntB_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-18-ATTCAGAA-ATAGAGGC_S27_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-18-ATTCAGAA-ATAGAGGC_S27_R2_001.fastq.gz"],
  "Astro_drugB_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-19-GAATTCGT-ATAGAGGC_S28_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-19-GAATTCGT-ATAGAGGC_S28_R2_001.fastq.gz"],
  "Astro_drugB_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-20-CTGAAGCT-ATAGAGGC_S29_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-20-CTGAAGCT-ATAGAGGC_S29_R2_001.fastq.gz"],

  "Mglia_cntB_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-21-TAATGCGC-ATAGAGGC_S30_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-21-TAATGCGC-ATAGAGGC_S30_R2_001.fastq.gz"],
  "Mglia_cntB_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-22-CGGCTATG-ATAGAGGC_S31_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-22-CGGCTATG-ATAGAGGC_S31_R2_001.fastq.gz"],
  "Mglia_drugB_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-23-TCCGCGAA-ATAGAGGC_S32_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-23-TCCGCGAA-ATAGAGGC_S32_R2_001.fastq.gz"],
  "Mglia_drugB_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-24-TCTCGCGC-ATAGAGGC_S33_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-24-TCTCGCGC-ATAGAGGC_S33_R2_001.fastq.gz"],

  "HMC_cntC_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-25-AGCGATAG-ATAGAGGC_S34_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-25-AGCGATAG-ATAGAGGC_S34_R2_001.fastq.gz"],
  "HMC_cntC_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-26-ATTACTCG-CCTATCCT_S35_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-26-ATTACTCG-CCTATCCT_S35_R2_001.fastq.gz"],
  "HMC_drugC_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-27-TCCGGAGA-CCTATCCT_S36_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-27-TCCGGAGA-CCTATCCT_S36_R2_001.fastq.gz"],
  "HMC_drugC_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-28-CGCTCATT-CCTATCCT_S37_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-28-CGCTCATT-CCTATCCT_S37_R2_001.fastq.gz"],

  "Astro_cntC_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-29-GAGATTCC-CCTATCCT_S38_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-29-GAGATTCC-CCTATCCT_S38_R2_001.fastq.gz"],
  "Astro_cntC_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-30-ATTCAGAA-CCTATCCT_S39_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-30-ATTCAGAA-CCTATCCT_S39_R2_001.fastq.gz"],
  "Astro_drugC_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-31-GAATTCGT-CCTATCCT_S40_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-31-GAATTCGT-CCTATCCT_S40_R2_001.fastq.gz"],
  "Astro_drugC_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-32-CTGAAGCT-CCTATCCT_S41_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-32-CTGAAGCT-CCTATCCT_S41_R2_001.fastq.gz"],

 "Mglia_cntC_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-33-TAATGCGC-CCTATCCT_S42_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-33-TAATGCGC-CCTATCCT_S42_R2_001.fastq.gz"],
  "Mglia_cntC_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-34-CGGCTATG-CCTATCCT_S43_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-34-CGGCTATG-CCTATCCT_S43_R2_001.fastq.gz"],
  "Mglia_drugC_1" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-35-TCCGCGAA-CCTATCCT_S44_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-35-TCCGCGAA-CCTATCCT_S44_R2_001.fastq.gz"],
  "Mglia_drugC_2" => ["/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-36-TCTCGCGC-CCTATCCT_S45_R1_001.fastq.gz", "/scratch/VANGARD/20181012_1159_Penn_RNAseq_human/1959/1959-CR-36-TCTCGCGC-CCTATCCT_S45_R2_001.fastq.gz"],

},


  #group information for visualization and comparison
 groups => {
  "HMC_cntA"	=> ["HMC_cntA_1", "HMC_cntA_2"],
  "HMC_drugA"	=> ["HMC_drugA_1", "HMC_drugA_2"],
  "Astro_cntA"  => ["Astro_cntA_1", "Astro_cntA_2"],
  "Astro_drugA"	=> ["Astro_drugA_1", "Astro_drugA_2"],
  "Mglia_cntA"  => ["Mglia_cntA_1", "Mglia_cntA_2"],
  "Mglia_drugA" => ["Mglia_drugA_1", "Mglia_drugA_2"],

  "HMC_cntB"    => ["HMC_cntB_1", "HMC_cntB_2"],
  "HMC_drugB"   => ["HMC_drugB_1", "HMC_drugB_2"],
  "Astro_cntB"  => ["Astro_cntB_1", "Astro_cntB_2"],
  "Astro_drugB" => ["Astro_drugB_1", "Astro_drugB_2"],
  "Mglia_cntB"  => ["Mglia_cntB_1", "Mglia_cntB_2"],
  "Mglia_drugB" => ["Mglia_drugB_1", "Mglia_drugB_2"],

  "HMC_cntC"    => ["HMC_cntC_1", "HMC_cntC_2"],
  "HMC_drugC"   => ["HMC_drugC_1", "HMC_drugC_2"],
  "Astro_cntC"  => ["Astro_cntC_1", "Astro_cntC_2"],
  "Astro_drugC" => ["Astro_drugC_1", "Astro_drugC_2"],
  "Mglia_cntC"  => ["Mglia_cntC_1", "Mglia_cntC_2"],
  "Mglia_drugC" => ["Mglia_drugC_1", "Mglia_drugC_2"],
},

  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
 pairs => {
  "HMC_drugA_vs_HMC_cntA"	=> ["HMC_cntA", "HMC_drugA"],
  "Astro_drugA_vs_Astro_cntA"   => ["Astro_cntA", "Astro_drugA"],
  "Mglia_drugA_vs_Mglia_cntA"   => ["Mglia_cntA", "Mglia_drugA"],

  "HMC_drugB_vs_HMC_cntB"       => ["HMC_cntB", "HMC_drugB"],
  "Astro_drugB_vs_Astro_cntB"   => ["Astro_cntB", "Astro_drugB"],
  "Mglia_drugB_vs_Mglia_cntB"   => ["Mglia_cntB", "Mglia_drugB"],

  "HMC_drugC_vs_HMC_cntC"       => ["HMC_cntC", "HMC_drugC"],
  "Astro_drugC_vs_Astro_cntC"   => ["Astro_cntC", "Astro_drugC"],
  "Mglia_drugC_vs_Mglia_cntC"   => ["Mglia_cntC", "Mglia_drugC"],

},

#perform enrichment analysis, organism should be: "athaliana" "btaurus"       "celegans"      "cfamiliaris"   "drerio"  "sscrofa"       "dmelanogaster" "ggallus"       "hsapiens"      "mmusculus"  "rnorvegicus"   "scerevisiae"
 perform_webgestalt => 1,
 webgestalt_organism => "hsapiens",

 perform_multiqc => 1,
  
 perform_report => 1,
 

};

performRNASeq_gatk_b37($def);
1;
