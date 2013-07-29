import sys
import re
import pysynth
import fpga2pysynth

if __name__ == '__main__':
	#name = sys.argv[1]
	repeat_loops = int(sys.stdin.readline())
	parsen = re.compile("(\d+)(\w#?(?:\d+)?)\s*(\d+)?")
	
	notes = []
	for line in sys.stdin.readlines():
		length,note,repeats = re.search(parsen,line).groups()
		if not repeats: repeats = 1
		repeats = int(repeats)
		length = int(length)

		notes += [(note,length)]*repeats
	
	notes = notes*repeat_loops

	#pysynth.make_wav(notes,fn=name,bpm=222)

	res = ""
	res += "memory_initialization_radix=10;\n"
	res += "memory_initialization_vector=\n"
	for n in notes:
		note,duration = n
		while duration <= 8:
			res += str(fpga2pysynth.encode_note(note)) + ",\n"
			duration *= 2
	print res[:-2] + ";"	
