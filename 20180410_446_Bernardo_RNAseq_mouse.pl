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
  email => "marisol.a.ramirez\@vanderbilt.edu",

  #target dir which will be automatically created and used to save code and result
  target_dir => "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/result",

  #source files
  files => {
    "Blast_6d_1"  => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-1_S1_R1_001.fastq.gz",   "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-1_S1_R2_001.fastq.gz" ],
    "Blast_6d_2"  => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-2_S2_R1_001.fastq.gz",   "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-2_S2_R2_001.fastq.gz" ],
    "Blast_6d_3"  => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-3_S3_R1_001.fastq.gz",   "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-3_S3_R2_001.fastq.gz" ],
    "Blast_6d_4"  => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-4_S4_R1_001.fastq.gz",   "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-4_S4_R2_001.fastq.gz" ],
    "Blast_6d_5"  => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-5_S5_R1_001.fastq.gz",   "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-5_S5_R2_001.fastq.gz" ],
    "Sham_1"      => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-6_S6_R1_001.fastq.gz",   "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-6_S6_R2_001.fastq.gz" ],
    "Sham_2"      => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-7_S7_R1_001.fastq.gz",   "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-7_S7_R2_001.fastq.gz" ],
    "Sham_3"      => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-8_S8_R1_001.fastq.gz",   "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-8_S8_R2_001.fastq.gz" ],
    "Sham_4"      => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-9_S9_R1_001.fastq.gz",   "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-9_S9_R2_001.fastq.gz" ],
    "Sham_5"      => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-10_S10_R1_001.fastq.gz", "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-10_S10_R2_001.fastq.gz" ],
    "Blast_10m_1" => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-11_S11_R1_001.fastq.gz", "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-11_S11_R2_001.fastq.gz" ],
    "Blast_10m_2" => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-12_S12_R1_001.fastq.gz", "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-12_S12_R2_001.fastq.gz" ],
    "Blast_10m_3" => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-13_S13_R1_001.fastq.gz", "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-13_S13_R2_001.fastq.gz" ],
    "Blast_10m_4" => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-14_S14_R1_001.fastq.gz", "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-14_S14_R2_001.fastq.gz" ],
    "Blast_10m_5" => [ "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-15_S15_R1_001.fastq.gz", "/scratch/VANGARD/20180410_446_Bernardo_RNAseq_mouse/446-ZL-15_S15_R2_001.fastq.gz" ],
  },

  #group information for visualization and comparison
  groups => {
    "Blast_6d"  => [ "Blast_6d_1",  "Blast_6d_2",  "Blast_6d_3",  "Blast_6d_4",  "Blast_6d_5" ],
    "Sham"      => [ "Sham_1",      "Sham_2",      "Sham_3",      "Sham_4",      "Sham_5" ],
    "Blast_10m" => [ "Blast_10m_1", "Blast_10m_2", "Blast_10m_3", "Blast_10m_4", "Blast_10m_5" ],
  },

  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
  pairs => {
    "Blast_6d_vs_Sham"  => [ "Sham", "Blast_6d" ],
    "Blast_10m_vs_Sham" => [ "Sham", "Blast_10m" ],
  },

  #perform enrichment analysis, organism should be: "athaliana" "btaurus"       "celegans"      "cfamiliaris"   "drerio"  "sscrofa"       "dmelanogaster" "ggallus"       "hsapiens"      "mmusculus"  "rnorvegicus"   "scerevisiae"
  perform_webgestalt  => 1,
  webgestalt_organism => "mmusculus",

  #perform multiqc
  perform_multiqc => 1,

  #perfomr report
  perform_report => 1,

};

performRNASeq_gencode_mm10($def);

1;
