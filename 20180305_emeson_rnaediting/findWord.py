import argparse
import sys
import logging
import os
import gzip

sys.path.insert(0, '/home/shengq2/program/ngsperl/lib/RNAediting')
from WordRoleUtils import WordRole

roles = {}

roles["Turnee_word"] = [
  WordRole("TurneeA", "AACCAT", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeB", "AACGTC", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeC", "AACTCA", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeD", "AAGACT", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeE", "ACTATT", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeH", "ATATGA", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeI", "CAATAT", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeJ", "CCTCGG", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeK", "CGCTTC", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeN", "GCAGAA", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeP", "GCGTCC", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeQ", "GGAGTC", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeT", "GTTGCC", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeU", "TACCGG", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeV", "TCAGCC", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeW", "TTCGGC", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
  WordRole("TurneeX", "TTGACC", 6, "GCTGGACCGGTATGTAGCA", 0.9, 25, "RTRCGTRRTCCTRTTGAGCATAGCCGGTTCAATTCGCGGACTAAGGCCATCATGAA", ['A', 'G']),
]

logger = logging.getLogger('findWord')
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)-8s - %(message)s')

wordCounts = {}
discardCounts = {}

rootFolder = "/scratch/VANGARD/20180305_turnee_rnaediting/"
fileName = rootFolder + "1364-TM-1_S1_R1_001.fastq.gz"
gzipped = fileName.endswith(".gz")
if gzipped:
  f = gzip.open(fileName, 'rt')
else:
  f = open(fileName, 'r')
  
def findWord(sequence, roles, wordCounts):
  for userName, userRoles in roles.iteritems():
    if not userName in wordCounts:
      wordCounts[userName] = {}
    userCounts = wordCounts[userName]
    
    if not userName in discardCounts:
      discardCounts[userName] = {}
    userDiscardCounts = discardCounts[userName]
    
    for role in userRoles:
      curWord = role.getWord(sequence)
      if curWord.discarded:
        if role.SampleName in userDiscardCounts:
          userDiscardCounts[role.SampleName] = userDiscardCounts[role.SampleName] + 1
        else: 
          userDiscardCounts[role.SampleName] = 1
        return(None)
      
      if len(curWord.word) > 0:
        if not role.SampleName in userCounts:
          userCounts[role.SampleName] = {}
        sampleCounts = userCounts[role.SampleName]
        
        if not curWord.word in sampleCounts:
          sampleCounts[curWord.word] = 1
        else:
          sampleCounts[curWord.word] = sampleCounts[curWord.word] + 1
        return(role)
      
  return(None)
  
fastqMap = {}
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
    
    role = findWord(sequence, roles, wordCounts)
    if role != None:
      if not role.SampleName in fastqMap:
        fastqFile = rootFolder + role.SampleName + ".fastq.gz"
        fastqMap[role.SampleName] = gzip.open(fastqFile, "wt")
      sw = fastqMap[role.SampleName]
      sw.write("%s\n" % header.strip())
      sw.write("%s\n" % sequence)
      sw.write("%s\n" % line3.strip())
      sw.write("%s\n" % line4.strip())
    
    count = count+1
    if count % 100000 == 0:
      logger.info("%d reads processed" % count)

    #if count % 20000 == 0:
    #  break
finally:
  f.close()

logger.info("total %d reads processed" % count)
  
for sw in fastqMap.values():
  sw.close()

for userName, userCounts in wordCounts.iteritems():
  samples = sorted(userCounts.iterkeys())
  totalCounts = {sample:sum(userCounts[sample].values()) for sample in samples}
  words = sorted(set( val for dic in userCounts.values() for val in dic.keys()))
  
  with open(rootFolder + userName + ".count.txt", "w") as swCount:
    with open(rootFolder + userName + ".perc.txt", "w") as swPerc:
      header = "Word\t%s\n" % "\t".join(samples)
      swCount.write(header)
      swPerc.write(header)
      
      for word in words:
        swCount.write(word)
        swPerc.write(word)
        for sample in samples:
          sampleCounts = userCounts[sample]
          if word in sampleCounts:
            swCount.write("\t%d" % sampleCounts[word])
            swPerc.write("\t%.4f" % (sampleCounts[word] * 1.0 / totalCounts[sample]))
          else:
            swCount.write("\t0")
            swPerc.write("\t0")
        swCount.write("\n")
        swPerc.write("\n")
        
      swCount.write("TotalWord\t%s\n" % "\t".join([str(totalCounts[sample]) for sample in samples]))
      swCount.write("DiscardRead\t%s\n" % "\t".join([str(discardCounts[userName][sample]) for sample in samples]))
  
  gPerc = {}    
  for sample in samples:
    gPerc[sample] = {}
    sampleCounts = userCounts[sample]
    for word in sampleCounts:
      maxChrInd = len(word)
      wCount = sampleCounts[word]
      for chrInx in range(0, len(word)) :
        if chrInx in gPerc[sample]:
          chrMap = gPerc[sample][chrInx]
        else:
          chrMap = {'G':0, 'R':0}
          gPerc[sample][chrInx] = chrMap
          
        if word[chrInx] == 'G':
          chrMap['G'] = chrMap['G'] + wCount
        else:
          chrMap['R'] = chrMap['R'] + wCount
  
  with open(rootFolder + userName + ".G.txt", "w") as swG:
    swG.write("Word\t%s\n" % "\t".join(samples))
    for chrInd in range(0, maxChrInd):
      word = 'R' * chrInd + 'G' + 'R' *(maxChrInd - chrInd - 1)
      swG.write(word)
      for sample in samples:
        chrMap = gPerc[sample][chrInd]
        perc = chrMap['G'] * 1.0 / (chrMap['G'] + chrMap['R'])
        swG.write('\t%.4f' % perc)
      swG.write('\n')
      
logger.info("done")
