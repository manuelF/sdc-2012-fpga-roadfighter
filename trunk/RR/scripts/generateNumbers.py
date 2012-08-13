letras=[]
#0
letras.append (
            "01110 "
            "10001 " 
            "10001 " 
            "10001 " 
            "01110 ")
#1
letras.append (
           "01100 "
           "00100 "
           "00100 "
           "00100 "
           "01110 ")
#2
letras.append (
           "01110 "
           "00010 "
           "01110 "
           "01000 "
           "01110 ")
#3
letras.append (
           "01110 "
           "00010 "
           "01110 "
           "00010 "
           "01110 ")
#4
letras.append (
           "00110 "
           "01010 "
           "11110 "
           "01010 "
           "01010 ")
#5
letras.append (
           "01110 "
           "01000 "
           "01110 "
           "01010 "
           "01110 ")
#6
letras.append (
           "01110 "
           "01010 "
           "01110 "
           "01010 "
           "01110 ")
#7
letras.append (
           "01110 "
           "01010 "
           "00010 "
           "00010 "
           "00010 ")
#8
letras.append (
           "01110 "
           "01010 "
           "01110 "
           "01010 "
           "01110 ")
#9
letras.append (
           "01110 "
           "01010 "
           "01110 "
           "00010 "
           "01110 ")

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
