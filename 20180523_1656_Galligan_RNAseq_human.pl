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
  target_dir => "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/result_cutadapt",

  #perform cutadapt
  perform_cutadapt => 1,
  cutadapt_option  => "-O 1",
  adapter          => "AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC",    #trueseq adapter
  adapter_5 => "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTA",
  min_read_length  => 30,
  #source files
files => {
  "JG-01" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-1-ATTACTCG-TATAGCCT_S69_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-1-ATTACTCG-TATAGCCT_S69_R2_001.fastq.gz"],
  "JG-02" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-2-TCCGGAGA-TATAGCCT_S70_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-2-TCCGGAGA-TATAGCCT_S70_R2_001.fastq.gz"],
  "JG-03" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-3-CGCTCATT-TATAGCCT_S71_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-3-CGCTCATT-TATAGCCT_S71_R2_001.fastq.gz"],
  "JG-04" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-4-GAGATTCC-TATAGCCT_S72_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-4-GAGATTCC-TATAGCCT_S72_R2_001.fastq.gz"],
  "JG-05" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-5-ATTCAGAA-TATAGCCT_S73_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-5-ATTCAGAA-TATAGCCT_S73_R2_001.fastq.gz"],
  "JG-06" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-6-GAATTCGT-TATAGCCT_S74_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-6-GAATTCGT-TATAGCCT_S74_R2_001.fastq.gz"],
  "JG-07" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-7-CTGAAGCT-TATAGCCT_S75_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-7-CTGAAGCT-TATAGCCT_S75_R2_001.fastq.gz"],
  "JG-08" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-8-TAATGCGC-TATAGCCT_S76_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-8-TAATGCGC-TATAGCCT_S76_R2_001.fastq.gz"],
  "JG-09" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-9-CGGCTATG-TATAGCCT_S77_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-9-CGGCTATG-TATAGCCT_S77_R2_001.fastq.gz"],
  "JG-10" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-10-TCCGCGAA-TATAGCCT_S78_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-10-TCCGCGAA-TATAGCCT_S78_R2_001.fastq.gz"],
  "JG-11" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-11-TCTCGCGC-TATAGCCT_S79_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-11-TCTCGCGC-TATAGCCT_S79_R2_001.fastq.gz"],
  "JG-12" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-12-AGCGATAG-TATAGCCT_S80_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-12-AGCGATAG-TATAGCCT_S80_R2_001.fastq.gz"],
  "JG-13" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-13-ATTACTCG-ATAGAGGC_S81_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-13-ATTACTCG-ATAGAGGC_S81_R2_001.fastq.gz"],
  "JG-14" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-14-TCCGGAGA-ATAGAGGC_S82_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-14-TCCGGAGA-ATAGAGGC_S82_R2_001.fastq.gz"],
  "JG-15" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-15-CGCTCATT-ATAGAGGC_S83_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-15-CGCTCATT-ATAGAGGC_S83_R2_001.fastq.gz"],
  "JG-16" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-16-GAGATTCC-ATAGAGGC_S84_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-16-GAGATTCC-ATAGAGGC_S84_R2_001.fastq.gz"],
  "JG-17" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-17-ATTCAGAA-ATAGAGGC_S85_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-17-ATTCAGAA-ATAGAGGC_S85_R2_001.fastq.gz"],
  "JG-18" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-18-GAATTCGT-ATAGAGGC_S86_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-18-GAATTCGT-ATAGAGGC_S86_R2_001.fastq.gz"],
  "JG-19" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-19-CTGAAGCT-ATAGAGGC_S87_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-19-CTGAAGCT-ATAGAGGC_S87_R2_001.fastq.gz"],
  "JG-20" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-20-TAATGCGC-ATAGAGGC_S88_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-20-TAATGCGC-ATAGAGGC_S88_R2_001.fastq.gz"],
  "JG-21" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-21-CGGCTATG-ATAGAGGC_S89_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-21-CGGCTATG-ATAGAGGC_S89_R2_001.fastq.gz"],
  "JG-22" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-22-TCCGCGAA-ATAGAGGC_S90_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-22-TCCGCGAA-ATAGAGGC_S90_R2_001.fastq.gz"],
  "JG-23" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-23-TCTCGCGC-ATAGAGGC_S91_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-23-TCTCGCGC-ATAGAGGC_S91_R2_001.fastq.gz"],
  "JG-24" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-24-AGCGATAG-ATAGAGGC_S92_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-24-AGCGATAG-ATAGAGGC_S92_R2_001.fastq.gz"],
  "JG-25" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-25-ATTACTCG-CCTATCCT_S93_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-25-ATTACTCG-CCTATCCT_S93_R2_001.fastq.gz"],
  "JG-26" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-26-TCCGGAGA-CCTATCCT_S94_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-26-TCCGGAGA-CCTATCCT_S94_R2_001.fastq.gz"],
  "JG-27" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-27-CGCTCATT-CCTATCCT_S95_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-27-CGCTCATT-CCTATCCT_S95_R2_001.fastq.gz"],
  "JG-28" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-28-GAGATTCC-CCTATCCT_S96_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-28-GAGATTCC-CCTATCCT_S96_R2_001.fastq.gz"],
  "JG-29" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-29-ATTCAGAA-CCTATCCT_S97_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-29-ATTCAGAA-CCTATCCT_S97_R2_001.fastq.gz"],
  "JG-30" => ["/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-30-GAATTCGT-CCTATCCT_S98_R1_001.fastq.gz", "/scratch/VANGARD/20180522_1656_Galligan_RNAseq_human/1656/1656-JG-30-GAATTCGT-CCTATCCT_S98_R2_001.fastq.gz"],
},


  #group information for visualization and comparison
 groups => {
    "WT_Vehicle" 	=> ["JG-01", "JG-02", "JG-03"],
    "GLO1KO_Vehicle" 	=> ["JG-04", "JG-05", "JG-06" ],
    "DJ1KO_Vehicle"	=> ["JG-07", "JG-08", "JG-09"],
    "DKO_Vehicle" 	=> ["JG-10", "JG-11", "JG-12"],
    "WT_50_MGO" 	=> ["JG-13", "JG-14", "JG-15"],
    "GLO1KO_50_MGO" 	=> ["JG-16", "JG-17", "JG-18"],
    "DJ1KO_50_MGO" 	=> ["JG-19", "JG-20", "JG-21"],
    "DKO_50_MGO" 	=> ["JG-22", "JG-23" , "JG-24" ],
    "WT_500_MGO" 	=> ["JG-25", "JG-26", "JG-27"],
    "GLO1KO_500_MGO" 	=> ["JG-28", "JG-29", "JG-30" ],
  },

  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
  pairs => {
    "WT_Vehicle_vs_GLO1KO_Vehicle"	=> ["WT_Vehicle", "GLO1KO_Vehicle" ],
    "WT_Vehicle_vs_DJ1KO_Vehicle"	=> ["WT_Vehicle", "DJ1KO_Vehicle"],
    "WT_Vehicle_vs_DKO_Vehicle"		=> ["WT_Vehicle", "DKO_Vehicle"],
    "WT_Vehicle_vs_WT_50_MGO" 		=> ["WT_Vehicle", "WT_50_MGO"],
    "WT_Vehicle_vs_GLO1KO_50_MGO" 	=> ["WT_Vehicle", "GLO1KO_50_MGO"],
    "WT_Vehicle_vs_DJ1KO_50_MGO" 	=> ["WT_Vehicle", "DJ1KO_50_MGO"],
    "WT_Vehicle_vs_DKO_50_MGO" 		=> ["WT_Vehicle", "DKO_50_MGO"],
    "WT_Vehicle_vs_WT_500_MGO" 		=> ["WT_Vehicle", "WT_500_MGO" ],
    "WT_Vehicle_vs_GLO1KO_500_MGO" 	=> ["WT_Vehicle", "GLO1KO_500_MGO"],
  },

#perform enrichment analysis, organism should be: "athaliana" "btaurus"       "celegans"      "cfamiliaris"   "drerio"  "sscrofa"       "dmelanogaster" "ggallus"       "hsapiens"      "mmusculus"  "rnorvegicus"   "scerevisiae"
 perform_webgestalt => 1,
 webgestalt_organism => "hsapiens",

 perform_multiqc => 1,
  
 perform_report => 1,
 

};

performRNASeq_gatk_b37($def);
1;
