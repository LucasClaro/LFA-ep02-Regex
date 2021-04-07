geral = /(?:Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa) [a-zA-Z0-9!\–º\(\)\-;':"\\,\/\. ãáõôêéí]{1,90} (?:[A-Z]{2}|\d{5}-?\d{3})/


file = File.open("exemplo.txt")
fileData = file.read
fileData.chomp
txt = fileData
file.close

nomes = txt.scan(geral)



dentro = Regexp.new(/(?<=Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa) [a-zA-Z0-9!\–º\(\)\-;':"\\,\/\. ãáõôêéí]{1,90} (?=[A-Z]{2}|\d{5}-?\d{3})/)

coisasDeDentro = []

for item in nomes
    coisasDeDentro.append(item.match(dentro)[0])
end

separaCampos = /[a-zA-Z0-9!º\(\);':"\\\/\. ãáõôêéí]{1,}/

camposDeDentro = []
for item in coisasDeDentro
    camposDeDentro.append(item.scan(separaCampos))
end

print camposDeDentro



Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa|AL|AL\.|Al|Al\.|Alameda|CPO|CPO\.|Cpo|Cpo\.|Campo|COND|COND\.|Cond|Cond\.|Condomínio|LG|LG\.|Lg|Lg\.|Lago|JD|JD\.|Jd|Jd\.|Jardim|PRQ|PRQ\.|Prq|Prq\.|Parque|PC|PC\.|Pc|Pc\.|Praça|VL|VL\.|Vl|Vl\.|Vila|
Rua |Av |Av\. |Avenida |R |R\. |Rodovia |Praça |Travessa |AL |AL\. |Al |Al\. |Alameda |CPO |CPO\. |Cpo |Cpo\. |Campo |COND |COND\. |Cond |Cond\. |Condomínio |LG |LG\. |Lg |Lg\. |Lago |JD |JD\. |Jd |Jd\. |Jardim |PRQ |PRQ\. |Prq |Prq\. |Parque |PC |PC\. |Pc |Pc\. |Praça |VL |VL\. |Vl |Vl\. |Vila |