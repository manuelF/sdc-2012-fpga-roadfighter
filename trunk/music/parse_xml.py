from xml.dom.minidom import parse
import fpga2pysynth,sys

durations = {
	"16th": 1,
	"eighth": 2,
	"quarter": 4,
	"half": 8,
	"whole": 16
}

def get_data(n,k): 
	v = n.getElementsByTagName(k)
	t = v[0].tagName if v else None
	if not t: return None
	return v[0].firstChild.data if v[0].firstChild else t
	
def get_child(n,k):
	v = n.getElementsByTagName(k);
	return v[0] if v else None
	
def get_note_data(node):
	note = get_data(node,"step") or ""
	alter = "#" if get_data(node,"alter") else ""

	octave = get_data(node,"octave")
	octave = octave if octave else "r"

	duration = durations[get_data(node,"type")]
	dot = get_data(node,"dot")
	mods = get_child(node,"time-modification")
	
	num,denom = 1,1
	if mods:
		num = int(get_data(mods,"normal-notes"))
		denom = int(get_data(mods,"actual-notes"))
	
	if dot: duration += duration/2
	duration *= 12 #Para que podamos tener triplets
	duration = (duration*num)/denom
	duration -= 1

	res = ""
	res += (str(fpga2pysynth.encode_note(note.lower() + alter + octave)) + ",\n")*duration	
	res += ("0,\n")

	return res

if __name__ == "__main__":
	dom = parse(sys.argv[1])
	notes = dom.getElementsByTagName("note")

	res = ""
	res += "memory_initialization_radix=10;\n"
	res += "memory_initialization_vector=\n"

	for note in notes[1:]:
		res += get_note_data(note)
	print res[:-2] + ";"
