#!/usr/bin/perl
use strict;
use warnings;

use CQS::FileUtils;
use CQS::PerformChIPSeq;

my $def = {
  task_name  => "peter_mouse",
  email      => "quanhu.sheng.1\@vanderbilt.edu",
  target_dir => create_directory_or_die("/scratch/VANGARD/20171207_peter_chipseq_mouse"),

  files => {
    "e18.5_A" => [
      "/scratch/VANGARD/20171207_peter_chipseq_mouse/fastq/CC0HLANXX_s8_1_GSLv3-7_93_SL279955.fastq.gz",
      "/scratch/VANGARD/20171207_peter_chipseq_mouse/fastq/CC0HLANXX_s8_2_GSLv3-7_93_SL279955.fastq.gz"
    ],
    "e18.5_B" => [
      "/scratch/VANGARD/20171207_peter_chipseq_mouse/fastq/CC0HLANXX_s8_1_GSLv3-7_94_SL279956.fastq.gz",
      "/scratch/VANGARD/20171207_peter_chipseq_mouse/fastq/CC0HLANXX_s8_2_GSLv3-7_94_SL279956.fastq.gz"
    ],
    "e18.5_A_input" => [
      "/scratch/VANGARD/20171207_peter_chipseq_mouse/fastq/CC0HLANXX_s8_1_GSLv3-7_95_SL279957.fastq.gz",
      "/scratch/VANGARD/20171207_peter_chipseq_mouse/fastq/CC0HLANXX_s8_2_GSLv3-7_95_SL279957.fastq.gz"
    ],
    "e18.5_B_input" => [
      "/scratch/VANGARD/20171207_peter_chipseq_mouse/fastq/CC0HLANXX_s8_1_GSLv3-7_96_SL279958.fastq.gz",
      "/scratch/VANGARD/20171207_peter_chipseq_mouse/fastq/CC0HLANXX_s8_2_GSLv3-7_96_SL279958.fastq.gz"
    ],
  },
  treatments => {
    "e18.5_A" => ["e18.5_A"],
    "e18.5_B" => ["e18.5_B"],
  },
  controls => {
    "e18.5_A" => ["e18.5_A_input"],
    "e18.5_B" => ["e18.5_B_input"],
  },
  pairend          => 1,
  perform_cutadapt => 0,

  aligner => "bwa",

  #peak
  peak_caller     => "macs2",
  macs2_peak_type => "narrow",
  macs2_genome    => "mm",

  perform_chipqc => 1,
  design_table   => {
    "e18.5" => {
      "e18.5_A" => {
        Condition => "e18.5",
        Replicate => "1"
      },
      "e18.5_B" => {
        Condition => "e18.5",
        Replicate => "2"
      },
    },
  },

  perform_homer => 1,
};

performChIPSeq_gencode_mm10($def);

1;
