from xml.dom.minidom import parse
import fpga2pysynth

durations = {
	"16th": 1,
	"eighth": 2,
	"quarter": 4
}

def get(n,k): 
	v = n.getElementsByTagName(k)
	t = v[0].tagName if v else None
	if not t: return None
	return v[0].firstChild.data if v[0].firstChild else t

def get_note_data(node):
	note = get(node,"step") or ""
	alter = "#" if get(node,"alter") else ""

	octave = get(node,"octave")
	octave = str(int(octave)+1) if octave else "r"

	duration = durations[get(node,"type")]
	dot = get(node,"dot")
	if dot: duration += duration/2

	duration *= 4
	res = ""
	while duration > 0:
		res += str(fpga2pysynth.encode_note(note.lower() + alter + octave)) + ",\n"
		duration -= 1
	res += "0,\n"
	return res

dom = parse("onlybass.xml")
notes = dom.getElementsByTagName("note")

res = ""
res += "memory_initialization_radix=10;\n"
res += "memory_initialization_vector=\n"

for note in notes[1:]:
	res += get_note_data(note)
print res[:-2] + ";"
