letras=[]
#TODAS LAS LETRAS TIENEN PADDING AL COSTADO PARA QUE SU ANCHO SEA MULTIPLO DE 8
#0
letras.append (
            "01111100 "
            "10000010 " 
            "10000010 " 
            "10000010 " 
            "10000010 " 
            "10000010 " 
            "01111100 ")
#1
letras.append (
           "01111000 "
           "00011000 "
           "00011000 "		   
           "00011000 "
           "00011000 "
           "00011000 "
           "01111100 ")
#2
letras.append (
           "01111100 "
           "00001100 "
           "01111100 "
           "01100000 "
           "01111100 ")
#3
letras.append (
           "01111100 "
           "00001100 "
           "01111100 "
           "00001100 "
           "01111100 ")
#4
letras.append (
			"00011100 "
			"00111100 "
			"01101100 "
			"11001100 "
			"11111100 "
			"00001100 "
			"00001100 ")
#5
letras.append (
			"11111110 "
			"10000000 "
			"10000000 "
			"11111110 "
			"00000010 "
			"00000010 "
			"11111110 ")
#6
letras.append (
			"01111100 "
			"10000000 "
			"10000000 "
			"11111100 "
			"10000010 "
			"10000010 "
			"01111100 "
)
#7
letras.append (
			"11111110 "
			"00000110 "
			"00001100 "
			"00011000 "
			"00110000 "
			"01100000 "
			"11000000 "
)
#8
letras.append (
			"01111100 "
			"10000010 "
			"10000010 "
			"01111100 "
			"10000010 "
			"10000010 "
			"01111100 "
)
#9
letras.append (
			"01111100 "
			"10000010 "
			"10000010 "
			"01111110 "
			"00000010 "
			"00000010 "
			"01111100 "
)

def colorear(simplecanal):
    salida= []
    for m in simplecanal:
        if(m=='0'):
            salida.append("111") #pinto de blano
        else:
            salida.append("000") #pinto de negro la letra propiamente dicha
    return ''.join(salida)
    

def gennumber(i):
    chars = letras[i]
    lines = chars.split(' ')
    out = []
    print "// Letra " + str(i)
    for nro, l in enumerate(lines):
        if(len(l)>0):
            triplecanal = colorear(l)
            out.append("letra"+str(i)+"[" + str(nro) + "] = " + str(len(triplecanal)) + "'b" + triplecanal + ";")
    return out

def main():
    for i in range(0,10):
        out = gennumber(i)
        print '\n'.join(out) + '\n'

if __name__=="__main__":
    main()
