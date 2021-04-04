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