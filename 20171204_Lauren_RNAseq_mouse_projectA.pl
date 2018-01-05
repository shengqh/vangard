#!/usr/bin/perl
use strict;
use warnings;

use CQS::ClassFactory;
use CQS::FileUtils;
use CQS::SystemUtils;
use CQS::ConfigUtils;
use Pipeline::RNASeq;

my $def = {

  #define task name, this name will be used as prefix of a few result, such as read count table file name.
  task_name => "RNAseq_mouse",

  #email which will be used for notification if you run through cluster
  email => "baohong.liu\@vanderbilt.edu",

  #target dir which will be automatically created and used to save code and result
  target_dir => "/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/RNASeq_result",

  #cqs in house software which will be used to generate count table. https://github.com/shengqh/CQS.Tools/
  cqstools => "/home/shengq2/cqstools/cqstools.exe",

  #gene annotation file
  transcript_gtf => "/scratch/cqs/shengq2/references/gencode/mm10/gencode.vM12.chr_patch_hapl_scaff.annotation.gtf",

  #gene name to transcription name map file which is generated by "mono cqstools.exe gtf_buildmap".
  name_map_file => "/scratch/cqs/shengq2/references/gencode/mm10/gencode.vM12.chr_patch_hapl_scaff.annotation.map",

  #genome sequence file
  fasta_file => "/scratch/cqs/shengq2/references/gencode/mm10/GRCm38.p5.genome.fa",

  #using STAR.
  aligner    => "star",
  star_index => "/scratch/cqs/shengq2/references/gencode/mm10/STAR_index_2.5.2b_gencodeVM12_sjdb99",

  #perform RNASeQC or not
  perform_rnaseqc => 0,
  rnaseqc_jar     => "/home/shengq2/local/bin/RNA-SeQC_v1.1.8.jar",

  #source files
  files => {
  "983-LW-1.1" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/399-RF-1_S1547_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/399-RF-1_S1547_R2_001.fastq.gz"],
  "983-LW-2.1" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/399-RF-2_S1548_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/399-RF-2_S1548_R2_001.fastq.gz"],
  "983-LW-2.2" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/399-RF-3_S1549_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/399-RF-3_S1549_R2_001.fastq.gz"],
  "983-LW-1" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/983-LW-1-ATTACTCG-TATAGCCT_S385_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/983-LW-1-ATTACTCG-TATAGCCT_S385_R2_001.fastq.gz"],
  "983-LW-2" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/983-LW-2-TCCGGAGA-TATAGCCT_S386_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/983-LW-2-TCCGGAGA-TATAGCCT_S386_R2_001.fastq.gz"],
  "983-LW-3" => ["/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/983-LW-3-CGCTCATT-TATAGCCT_S387_R1_001.fastq.gz","/scratch/VANGARD/20171204_Lauren_RNA_seq_mouse/ProjectA/983-LW-3-CGCTCATT-TATAGCCT_S387_R2_001.fastq.gz"],
},

  #group information for visualization and comparison
  groups => {
    "injected" => [ "983-LW-1.1","983-LW-2.1","983-LW-2.2" ],
    "control" => [ "983-LW-1","983-LW-2","983-LW-3" ],
        
  },

  #Comparison information, in each comparison, the first one is control. For example, in comparison "DMSO_vs_FED", "FED" is control.
  pairs => {
    "injected_vs_control" => [ "control", "injected" ], 
    		
    
    	
    
  },
  
  #perform enrichment analysis, organism should be: "athaliana" "btaurus"       "celegans"      "cfamiliaris"   "drerio"  "sscrofa"       "dmelanogaster" "ggallus"       "hsapiens"      "mmusculus"  "rnorvegicus"   "scerevisiae"   
  perform_webgestalt => 1,
  webgestalt_organism => "mmusculus", 
  
  #perform multiqc
  perform_multiqc => 1,
};

performRNASeq($def);

1;
