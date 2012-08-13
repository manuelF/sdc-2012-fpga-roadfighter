import csv, sys

def fix(nro):
	return str(nro).zfill(3)

def main(archivo,salida=sys.stdout):
	salida.write(";" + archivo +"\n")
	filereader = csv.reader(open(archivo, 'r'), delimiter=',')
	radix = 2
	salida.write( "memory_initialization_radix=" + str(radix) + ";\n")
	salida.write( "memory_initialization_vector=\n")
	l = []
	for linea in filereader:
		l.append( ''.join(map(fix, linea[::-1])))
	salida.write(',\n'.join(l) + ";\n")
	return (len(l[0]),len(l))

if __name__=='__main__':
	#archivo = sys.argv[1]
	archivo = "Enemy "
	for i in range(1,7):
		fcsv = archivo+ str(i)+".csv"
		fcoe = archivo+ str(i)+".coe"
		with open(fcoe,"w") as salida:
			dims = main(fcsv,salida)
			print "%d %d" % dims
