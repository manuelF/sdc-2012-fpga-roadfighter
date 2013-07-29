import re
import sys
import pysynth_b

note_names = ["a","a#","b","c","c#","d","d#","e","f","f#","g","g#"]
def decode_note(value):
	if value == 0: return 'r'
	global note_names
	current_note = 0
	current_octave = 2
	while value > 0:
		current_note += 1
		if current_note == 12:
			current_note = 0
		if note_names[current_note] == "c":
			current_octave += 1	
		value -= 1
	return note_names[current_note] + str(current_octave)

def encode_note(value):
	val = 0
	while val < 200:
		if decode_note(val) == value:
			return val
		val = val+1
	return ""

def note_duration(value):
	val = 8
	while value > 1:
		value /= 2
		val /= 2
	return val

def parse(original):
	notes = []
	for line in original:
		line = line.strip().replace(" ","")
		if re.search("((\d+)|\[(\d+)\.\.(\d+)\]):\d+",line):
			m = re.search("(\d+):(\d+)",line)
			if m:
				value = int(m.group(2))
				notes.append((decode_note(value),8))
				continue
			m = re.search("\[(\d+)\.\.(\d+)\]:(\d+)",line)
			if m:
				st,en,val = map(int,m.groups())
				notes.append((decode_note(val),note_duration(en-st+1)))
	return notes

if __name__=='__main__':
	notes = parse(sys.stdin.readlines())
	pysynth_b.make_wav(tuple(notes),fn="test.wav",bpm=190)

