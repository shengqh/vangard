#!/usr/bin/perl
use strict;
use warnings;

use CQS::FileUtils;
use CQS::SystemUtils;
use CQS::ConfigUtils;
use CQS::ClassFactory;
use Pipeline::ExomeSeq;

my $def = {
  task_name  => "Wos_exomeseq",
  target_dir => create_directory_or_die("/scratch/cqs/shengq2/test/20171111_Wos_exomeseq"),
  email      => "quanhu.sheng.1\@vanderbilt.edu",
  cqstools   => "/home/shengq2/cqstools/cqstools.exe",

  #mapping
  aligner    => "bwa",
  bwa_fasta  => "/scratch/h_vangard_1/guoy1/reference/pombe34/bwa_index_0.7.15/pombe34.fa",
  picard_jar => "/scratch/cqs/shengq2/local/bin/picard/picard.jar",

  #gatk4_jar   => "/scratch/cqs/shengq2/tools/GATK4.jar",

  #refine
  gatk_jar => "/scratch/cqs/shengq2/local/bin/gatk/GenomeAnalysisTK.jar",
  dbsnp    => "/scratch/cqs/shengq2/references/ensembl/fungi_v37/pombe34.vcf",

  #somatic mutation
  perform_muTect      => 1,
  indel_realignment   => 1,
  muTect_init_command => "setpkgs -a java",
  muTect_option       => "--min_qscore 20 --filter_reads_with_N_cigar",
  muTect_jar          => "/home/shengq2/local/bin/mutect-1.1.7.jar",

  #annotation
  perform_annovar  => 0,
  annovar_param    => "-protocol schizosaccharomyces_pombe -operation f",
  annovar_db       => "/scratch/h_vangard_1/guoy1/reference/vcf3/",
  annovar_buildver => "pombe34",

  files => {
    "MW_503_1" => [ "/gpfs23/scratch/cqs/guom1/rawdata_BK/503MW_rawdata/503-MW-1_S7_R1_001.fastq", "/gpfs23/scratch/cqs/guom1/rawdata_BK/503MW_rawdata/503-MW-1_S7_R2_001.fastq" ],
    "MW_503_2" => [ "/gpfs23/scratch/cqs/guom1/rawdata_BK/503MW_rawdata/503-MW-2_S8_R1_001.fastq", "/gpfs23/scratch/cqs/guom1/rawdata_BK/503MW_rawdata/503-MW-2_S8_R2_001.fastq" ],
  },
  groups => {
    "MW_503" => [ "MW_503_1", "MW_503_2" ]
  }
};

performExomeSeq($def);

1;

