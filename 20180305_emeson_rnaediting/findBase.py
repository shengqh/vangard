import argparse
import sys
import logging
import os
import gzip

sys.path.insert(0, '/home/shengq2/program/ngsperl/lib/RNAediting')
from BaseRoleUtils import BaseRoleCriteria, BaseRole

roles = {}

chrisCriteria = BaseRoleCriteria(6, "ATTAACCCTCACTAAAGGGA", 0.9, 26, "CTCCGTCTCGATCATGGTGGCCAACATCCTCCGCCTCTTCAAGATCCCTCAGATCAGCTATGCCTCCACGGCCCCTGACTTGAGTGACAACAGCCGCTATGACTTCTTCTCCCGGGTGGTGCCCTCAGACACATACCAG" , 0.9)
roles["Chris_base"] = [
  BaseRole("Chris_CR1", "AACCAT", chrisCriteria),
  BaseRole("Chris_CR2", "AACGTC", chrisCriteria),
  BaseRole("Chris_CR3", "AACTCA", chrisCriteria),
  BaseRole("Chris_CT1", "AAGACT", chrisCriteria),
  BaseRole("Chris_CT2", "ACTATT", chrisCriteria),
  BaseRole("Chris_CT3", "AGATAC", chrisCriteria),
  BaseRole("Chris_HC1", "AGGCGG", chrisCriteria),
  BaseRole("Chris_HC2", "ATATGA", chrisCriteria),
  BaseRole("Chris_HC3", "CAATAT", chrisCriteria),
  BaseRole("Chris_HT1", "CCTCGG", chrisCriteria),
  BaseRole("Chris_HT2", "CGCTTC", chrisCriteria),
  BaseRole("Chris_HT3", "CGTCTT", chrisCriteria),
  BaseRole("Chris_ST1", "CTGCAT", chrisCriteria),
  BaseRole("Chris_ST2", "GCAGAA", chrisCriteria),
  BaseRole("Chris_ST3", "GCGATG", chrisCriteria),
  BaseRole("Chris_C1", "GCGTCC", chrisCriteria),
  BaseRole("Chris_C2", "GGAGTC", chrisCriteria),
  BaseRole("Chris_C3", "GGTAGG", chrisCriteria),
  BaseRole("Chris_K1", "GTTAAT", chrisCriteria),
  BaseRole("Chris_K2", "GTTGCC", chrisCriteria),
  BaseRole("Chris_K3", "TACCGG", chrisCriteria),
  BaseRole("Chris_S1", "TCAGCC", chrisCriteria),
  BaseRole("Chris_S2", "TTCGGC", chrisCriteria),
  BaseRole("Chris_S3", "TTGACC", chrisCriteria),
]

turneeCriteria = BaseRoleCriteria(6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "GTGCGTAATCCTGTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA" , 0.9)
roles["Turnee_base"] = [
  BaseRole("TurneeA", "AACCAT", turneeCriteria),
  BaseRole("TurneeB", "AACGTC", turneeCriteria),
  BaseRole("TurneeC", "AACTCA", turneeCriteria),
  BaseRole("TurneeD", "AAGACT", turneeCriteria),
  BaseRole("TurneeE", "ACTATT", turneeCriteria),
  BaseRole("TurneeH", "ATATGA", turneeCriteria),
  BaseRole("TurneeI", "CAATAT", turneeCriteria),
  BaseRole("TurneeJ", "CCTCGG", turneeCriteria),
  BaseRole("TurneeK", "CGCTTC", turneeCriteria),
  BaseRole("TurneeN", "GCAGAA", turneeCriteria),
  BaseRole("TurneeP", "GCGTCC", turneeCriteria),
  BaseRole("TurneeQ", "GGAGTC", turneeCriteria),
  BaseRole("TurneeT", "GTTGCC", turneeCriteria),
  BaseRole("TurneeU", "TACCGG", turneeCriteria),
  BaseRole("TurneeV", "TCAGCC", turneeCriteria),
  BaseRole("TurneeW", "TTCGGC", turneeCriteria),
  BaseRole("TurneeX", "TTGACC", turneeCriteria),
]

logger = logging.getLogger('findBase')
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)-8s - %(message)s')

wordCounts = {}

rootFolder = "/scratch/VANGARD/20180305_turnee_rnaediting/"
fileName = rootFolder + "1364-TM-1_S1_R1_001.fastq.gz"
gzipped = fileName.endswith(".gz")
if gzipped:
  f = gzip.open(fileName, 'rt')
else:
  f = open(fileName, 'r')
  
def findBase(sequence, roles):
  for userRoles in roles.values():
    for role in userRoles:
      res = role.fillBaseDict(sequence)
      if res.filled or res.discarded:
        return
  
try:
  count = 0
  while True:
    header = f.readline()
    if '' == header:
      break
    if not header.startswith("@"):
      continue
    sequence = f.readline().strip()
    line3 = f.readline()
    line4 = f.readline()
    
    findBase(sequence, roles)
    
    count = count+1
    if count % 100000 == 0:
      logger.info("%d reads processed" % count)

    #if count % 20000 == 0:
    #  break
finally:
  f.close()

logger.info("total %d reads processed" % count)
  
for userName, userRoles in roles.iteritems():
  with open(rootFolder + userName + ".count.txt", "w") as swCount:
    with open(rootFolder + userName + ".perc.txt", "w") as swPerc:
      with open(rootFolder + userName + ".discard.txt", "w") as swDiscard:
        swDiscard.write("Sample\tTotal\tDiscard\tDiscardRate\n")
        header = "Sample\tPosition\tRef\tA\tT\tG\tC\tMinor\tValid";
        swCount.write("%s\n" % header)
        swPerc.write("%s\n" % header)
        for role in userRoles:
          if role.TotalRead == 0:
            swDiscard.write("%s\t0\t0\t0\n" % role.SampleName)
          else:
            swDiscard.write("%s\t%d\t%d\t%.4f\n" %(role.SampleName, role.TotalRead, role.DiscardRead, role.DiscardRead * 1.0 / role.TotalRead))
          for idx in role.BaseDict:
            line = "%s\t%d\t%s" % (role.SampleName, idx, role.Criteria.IdenticalSequence[idx])
            swCount.write(line)
            swPerc.write(line)
            idxDict = role.BaseDict[idx]
            totalValid = sum(idxDict.values())
            for base in ['A', 'T', 'G', 'C']:
              if base in idxDict:
                swCount.write("\t%s" % idxDict[base])
                swPerc.write("\t%.4f" % (idxDict[base] * 1.0 / totalValid))
              else:
                swCount.write("\t0")
                swPerc.write("\t0")
            counts = [idxDict[base] for base in ['A', 'T', 'G', 'C'] if base != role.Criteria.IdenticalSequence[idx] and base in idxDict]
            minorCount = max(counts) if len(counts) > 0 else 0
            swCount.write("\t%d\t%d\n" % (minorCount, totalValid))
            swPerc.write("\t%.4f\t%d\n" % (minorCount * 1.0 / totalValid, totalValid))
      
logger.info("done")
