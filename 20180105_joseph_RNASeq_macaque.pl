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
  task_name => "JapaneseMacaque",

  #email which will be used for notification if you run through cluster
  email => "quanhu.sheng.1\@vanderbilt.edu",

  #target dir which will be automatically created and used to save code and result
  target_dir => "/scratch/VANGARD/20180105_joseph_RNASeq_macaque",

  #cqs in house software which will be used to generate count table. https://github.com/shengqh/CQS.Tools/
  cqstools => "/home/shengq2/cqstools/cqstools.exe",

  perform_cutadapt => 0,
  cutadapt_option  => "-O 1",
  adapter          => "AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC",    #trueseq adapter
  min_read_length  => 30,

  pairend => 1,

  #source files
  files => {
    "CTR_33215_F" => [
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_1_GSLv3-7_28_SL281210.fastq.gz",
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_2_GSLv3-7_28_SL281210.fastq.gz"
    ],
    "CTR_33316_M" => [
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_1_GSLv3-7_29_SL281211.fastq.gz",
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_2_GSLv3-7_29_SL281211.fastq.gz"
    ],
    "HFD_33499_M" => [
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_1_GSLv3-7_30_SL281212.fastq.gz",
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_2_GSLv3-7_30_SL281212.fastq.gz"
    ],
    "HFD_33512_M" => [
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_1_GSLv3-7_31_SL281213.fastq.gz",
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_2_GSLv3-7_31_SL281213.fastq.gz"
    ],
    "CTR_33657_F" => [
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_1_GSLv3-7_32_SL281214.fastq.gz",
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_2_GSLv3-7_32_SL281214.fastq.gz"
    ],
    "CTR_33401_F" => [
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_1_GSLv3-7_33_SL281215.fastq.gz",
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_2_GSLv3-7_33_SL281215.fastq.gz"
    ],
    "HFD_33337_F" => [
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_1_GSLv3-7_34_SL281216.fastq.gz",
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_2_GSLv3-7_34_SL281216.fastq.gz"
    ],
    "HFD_33500_F" => [
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_1_GSLv3-7_35_SL281217.fastq.gz",
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_2_GSLv3-7_35_SL281217.fastq.gz"
    ],
    "CTR_33573_M" => [
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_1_GSLv3-7_36_SL281218.fastq.gz",
      "/gpfs23/scratch/VANGARD/20180105_joseph_RNASeq_macaque/fastq/CBU7TANXX_s5_2_GSLv3-7_36_SL281218.fastq.gz"
    ],
  },

  groups => {
    "Control"     => [ "CTR_33215_F", "CTR_33316_M", "CTR_33657_F", "CTR_33401_F", "CTR_33573_M" ],
    "HighFatDiet" => [ "HFD_33499_M", "HFD_33512_M", "HFD_33337_F", "HFD_33500_F" ],
  },

  pairs => {
    "HighFatDiet_vs_Control_gender" => {
      groups => [ "Control", "HighFatDiet" ],
      gender => [ "Female",  "Male", "Female", "Female", "Male", "Male", "Male", "Female", "Female" ]
    },
    "HighFatDiet_vs_Control" => {
      groups => [ "Control", "HighFatDiet" ],
    }
  },
  DE_fold_change     => 1.5,
  perform_multiqc    => 1,
  perform_webgestalt => 0,
  perform_report => 1,
};

my $config = performRNASeq_ensembl_Mmul1($def, 0);
performTask($config, "report");

1;
