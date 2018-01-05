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
  target_dir => create_directory_or_die("/scratch/VANGARD/20171110_Wos_DNA_seq/844_result"),
  email      => "baohong.liu.1\@vanderbilt.edu",
  cqstools   => "/home/shengq2/cqstools/cqstools.exe",

  #mapping
  aligner    => "bwa",
  bwa_fasta  => "/scratch/cqs/shengq2/references/ensembl/fungi_v37/bwa_index_0.7.17/pombe34.fa",
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

  files => {
    "MW_844_1" => [ "/gpfs23/scratch/VANGARD/20171110_Wos_DNA_seq/844/844-MW-1_S1_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20171110_Wos_DNA_seq/844/844-MW-1_S1_R2_001.fastq.gz" ],
    "MW_844_2" => [ "/gpfs23/scratch/VANGARD/20171110_Wos_DNA_seq/844/844-MW-2_S2_R1_001.fastq.gz", "/gpfs23/scratch/VANGARD/20171110_Wos_DNA_seq/844/844-MW-2_S2_R2_001.fastq.gz" ],
  },
  groups => {
    "MW_844" => [ "MW_844_1", "MW_844_2" ]
  }
};

performExomeSeq($def);

1;

