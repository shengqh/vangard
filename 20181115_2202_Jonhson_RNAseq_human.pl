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
  target_dir => "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/result/",

  #perform cutadapt
  perform_cutadapt => 1,
  cutadapt_option  => "-q 20 -a AGATCGGAAGAGCACACGTC -A AGATCGGAAGAGCGTCGTGT",
  min_read_length  => 30,
 
 
#source files
files => {
  "MCF74A_1" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-11-AACCAGAG-CTTCGGTT_S124_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-11-AACCAGAG-CTTCGGTT_S124_R2_001.fastq.gz"],
  "MCF74A_2" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-13-GTACCACA-CCACAACA_S125_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-13-GTACCACA-CCACAACA_S125_R2_001.fastq.gz"],
  "MCF7MSCV_1" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-14-GGTATAGG-TACTCCAG_S126_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-14-GGTATAGG-TACTCCAG_S126_R2_001.fastq.gz"],
  "MCF7MSCV_2" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-17-CGAGAGAA-GGAAGAGA_S127_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-17-CGAGAGAA-GGAAGAGA_S127_R2_001.fastq.gz"],
  "MCF7MSCV_3" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-20-CAGCATAC-GCGTTAGA_S128_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-20-CAGCATAC-GCGTTAGA_S128_R2_001.fastq.gz"],
  "MCF74A_3" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-22-CTCGACTT-ATCTGACC_S129_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-22-CTCGACTT-ATCTGACC_S129_R2_001.fastq.gz"],
  "MCF71A67SEC_1" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-40-CTTCGGTT-AACCAGAG_S130_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-40-CTTCGGTT-AACCAGAG_S130_R2_001.fastq.gz"],
  "MCF71A67SEC_2" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-44-CCACAACA-GTACCACA_S131_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-44-CCACAACA-GTACCACA_S131_R2_001.fastq.gz"],
  "MCF71A67SEC_3" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-6-TACTCCAG-GGTATAGG_S120_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-6-TACTCCAG-GGTATAGG_S120_R2_001.fastq.gz"],
  "MCSF72A_1" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-7-GGAAGAGA-CGAGAGAA_S121_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-7-GGAAGAGA-CGAGAGAA_S121_R2_001.fastq.gz"],
  "MCSF72A_2" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-8-GCGTTAGA-CAGCATAC_S122_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-8-GCGTTAGA-CAGCATAC_S122_R2_001.fastq.gz"],
  "MCSF72A_3" => ["/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-9-ATCTGACC-CTCGACTT_S123_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20181115_2202_Jonhson_RNAseq_human/2202/2202-JJ-9-ATCTGACC-CTCGACTT_S123_R2_001.fastq.gz"],
},


  #group information for visualization and comparison
 groups => {
  "Pthlh_36_139_HA" => ["MCF74A_1", "MCF74A_2", "MCF74A_3"],
  "Pthlh_36_67_HA"  => ["MCF71A67SEC_1", "MCF71A67SEC_2", "MCF71A67SEC_3"],
  "Pthlh"        => ["MCSF72A_1", "MCSF72A_2", "MCSF72A_3"],
  "Control"	 => ["MCF7MSCV_1", "MCF7MSCV_2", "MCF7MSCV_3"],
},

  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
 pairs => {
  "Pthlh_36_139_HA_vs_Control"	=> ["Control","Pthlh_36_139_HA" ],
  "Pthlh_36_67_HA_vs_Control"   => ["Control","Pthlh_36_67_HA" ],
  "Pthlh_vs_Control"   		=> ["Control","Pthlh" ],
},

#perform enrichment analysis, organism should be: "athaliana" "btaurus"       "celegans"      "cfamiliaris"   "drerio"  "sscrofa"       "dmelanogaster" "ggallus"       "hsapiens"      "mmusculus"  "rnorvegicus"   "scerevisiae"
 perform_webgestalt => 1,
 webgestalt_organism => "hsapiens",

 perform_multiqc => 1,
  
 perform_report => 1,
 perform_gsea => 0, 

};

performRNASeq_gatk_b37($def);
1;
