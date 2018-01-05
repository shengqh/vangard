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
  email => "baohong.liu\@vanderbilt.edu",

  #target dir which will be automatically created and used to save code and result
  target_dir => "/scratch/VANGARD/20171211_YanLing_RNA_seq_human/RNAseq_result",

  #source files

files => {
  "HFL1_ctrlB" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-1_S1_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-1_S1_R2_001.fastq.gz"],
  "HFL1_ctrlA" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-3_S3_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-3_S3_R2_001.fastq.gz"],
  "HFL1_TBX4B" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-2_S2_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-2_S2_R2_001.fastq.gz"],
  "HFL1_TBX4A" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-4_S4_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-4_S4_R2_001.fastq.gz"],
  "PPH173_ctrlB" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-5_S5_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-5_S5_R2_001.fastq.gz"],
  "PPH173_ctrlA" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-7_S7_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-7_S7_R2_001.fastq.gz"],
  "PPH173_TBX4B" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-6_S6_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-6_S6_R2_001.fastq.gz"],
  "PPH173_TBX4A" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-8_S8_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-8_S8_R2_001.fastq.gz"],
  "SPH747_ctrlB" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-9_S1_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-9_S1_R2_001.fastq.gz"],
  "SPH747_ctrlA" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-11_S3_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-11_S3_R2_001.fastq.gz"],
  "SPH747_TBX4B" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-10_S2_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-10_S2_R2_001.fastq.gz"],
  "SPH747_TBX4A" => ["/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-12_S4_R1_001.fastq.gz","/gpfs23/scratch/VANGARD/20171211_YanLing_RNA_seq_human/599-LH-12_S4_R2_001.fastq.gz"],
},
  #group information for visualization and comparison
 groups => {
    "HFL1_ctrl" => [ "HFL1_ctrlB","HFL1_ctrlA" ],
    "HFL1_TBX4" => [ "HFL1_TBX4B","HFL1_TBX4A" ],
    "PPH173_ctrl" => [ "PPH173_ctrlB","PPH173_ctrlA" ],
    "PPH173_TBX4" => [ "PPH173_TBX4B","PPH173_TBX4A" ],
    "SPH747_ctrl" => [ "SPH747_ctrlB","SPH747_ctrlA" ],
    "SPH747_TBX4" => [ "SPH747_TBX4B","SPH747_TBX4A" ],

  },
  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
  pairs => {
    "HFL1_TBX4_vs_ctrl" => [ "HFL1_ctrl", "HFL1_TBX4" ],
    "PPH173_TBX4_vs_ctrl" => [ "PPH173_ctrl", "PPH173_TBX4" ],
    "SPH747_TBX4_vs_ctrl" => [ "SPH747_ctrl", "SPH747_TBX4" ],
   
  },

 perform_webgestalt => 1,
  webgestalt_organism => "hsapiens",

 perform_multiqc => 1,
  
};

performRNASeq_gatk_b37($def);

1;
