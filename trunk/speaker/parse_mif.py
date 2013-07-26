import re
import sys


def parse(original):
    ''' re 1:  (\d+)\s*:\s*(\d+);
        re 2:   \[((\d+)\.\.(\d+))\]\s*:\s*(\d+);
    '''
    print("memory_initialization_radix=10;")
    print("memory_initialization_vector=")

    flag = False
    strres = ""
    for line in original:
        line = line.strip().replace(" ","")
        if re.search("((\d+)|\[(\d+)\.\.(\d+)\]):\d+",line):
            m = re.search("(\d+):(\d+)",line)
            if m:
                strres += str(m.group(2))+",\n"
                continue
            m = re.search("\[(\d+)\.\.(\d+)\]:(\d+)",line)
            if m:
                st,en,val = map(int,m.groups())
                for v in xrange(st,en+1):
                    strres += str(val)+",\n"
    print strres[:-2] + ";"

if __name__=='__main__':
    parse(sys.stdin.readlines())