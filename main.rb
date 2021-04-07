class Extrator

    def initialize
        @cep =  /\d{5}-?\d{3}/
        @uf = /(?<=[ ,-])[A-Z]{2}(?=[\s,-])/        
        @tipoLogradouro = /(?:Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa|AL|AL\.|Al|Al\.|Alameda|CPO|CPO\.|Cpo|Cpo\.|Campo|COND|COND\.|Cond|Cond\.|Condomínio|LG|LG\.|Lg|Lg\.|Lago|JD|JD\.|Jd|Jd\.|Jardim|PRQ|PRQ\.|Prq|Prq\.|Parque|PC|PC\.|Pc|Pc\.|Praça|VL|VL\.|Vl|Vl\.|Vila)/
        @nomeDaRua = /(?<=Rua |Av |Av\. |Avenida |R |R\. |Rodovia |Praça |Travessa |AL |AL\. |Al |Al\. |Alameda |CPO |CPO\. |Cpo |Cpo\. |Campo |COND |COND\. |Cond |Cond\. |Condomínio |LG |LG\. |Lg |Lg\. |Lago |JD |JD\. |Jd |Jd\. |Jardim |PRQ |PRQ\. |Prq |Prq\. |Parque |PC |PC\. |Pc |Pc\. |Praça |VL |VL\. |Vl |Vl\. |Vila )[a-zA-Z0-9!\–º\(\)\-;':\\"\/\. ãáõôêéí]+(?=,)/
        @numero = /(?:\d+|S\/N)/

        @geral = /(?:Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa|AL|AL\.|Al|Al\.|Alameda|CPO|CPO\.|Cpo|Cpo\.|Campo|COND|COND\.|Cond|Cond\.|Condomínio|LG|LG\.|Lg|Lg\.|Lago|JD|JD\.|Jd|Jd\.|Jardim|PRQ|PRQ\.|Prq|Prq\.|Parque|PC|PC\.|Pc|Pc\.|Praça|VL|VL\.|Vl|Vl\.|Vila) [a-zA-Z0-9!\–º\(\)\-;':"\\,\/\. ãáõôêéí]{1,90} (?:[A-Z]{2}|\d{5}-?\d{3})/
        @geralComNamedGrp = /(?<tipo>Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa|AL|AL\.|Al|Al\.|Alameda|CPO|CPO\.|Cpo|Cpo\.|Campo|COND|COND\.|Cond|Cond\.|Condomínio|LG|LG\.|Lg|Lg\.|Lago|JD|JD\.|Jd|Jd\.|Jardim|PRQ|PRQ\.|Prq|Prq\.|Parque|PC|PC\.|Pc|Pc\.|Praça|VL|VL\.|Vl|Vl\.|Vila) [a-zA-Z0-9!\–º\(\)\-;':"\\,\/\. ãáõôêéí]{1,90} (?<fim>[A-Z]{2}|\d{5}-?\d{3})/
        @dentro = /(?<=Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa|AL|AL\.|Al|Al\.|Alameda|CPO|CPO\.|Cpo|Cpo\.|Campo|COND|COND\.|Cond|Cond\.|Condomínio|LG|LG\.|Lg|Lg\.|Lago|JD|JD\.|Jd|Jd\.|Jardim|PRQ|PRQ\.|Prq|Prq\.|Parque|PC|PC\.|Pc|Pc\.|Praça|VL|VL\.|Vl|Vl\.|Vila) [a-zA-Z0-9!\–º\(\)\-;':"\\,\/\. ãáõôêéí]{1,90} (?=[A-Z]{2}|\d{5}-?\d{3})/
        @separaCampos = /(?:(?:\d\-\d)|(?:\d\-\d)|[a-zA-Z0-9!º\(\);':"\\\/\. ãáõôêéí]){1,}/

        @vetorEnderecosFinal = []
        @txt = ""
    end

    def printar(dict)
        puts ("--------------------")
        puts dict["Endereco"]
        puts dict["Tipo"]
        puts dict["Nome"]
        puts dict["Numero"]
        puts dict["Complemento"]
        puts dict["Bairro"]
        puts dict["Cidade"]
        puts dict["Uf"]
        puts dict["Cep"]
        puts ("--------------------")
        puts
    end

    def initDict
        dict = {}
        dict["Endereco"] = "Endereco: N/A"
        dict["Tipo"] = "Tipo: N/A"
        dict["Nome"] = "Nome: N/A"
        dict["Numero"] = "Numero: N/A"
        dict["Complemento"] = "Complemento: N/A"
        dict["Bairro"] = "Bairro: N/A"
        dict["Cidade"] = "Cidade: N/A"
        dict["Uf"] = "Uf: N/A"
        dict["Cep"] = "Cep: N/A"
        return dict
    end

    def iniciar
        puts ("Digite 1 para entrar com os dados através de um arquivo")
        puts ("Digite 2 para entrar com os dados manualmente")
        num = gets.chomp()
        if (num == "1")
            iniciarArquivo
        else
            if (num == "2")
                iniciarGets
            else
                puts ('Entrada inválida')
                iniciar
            end
        end
    end

    def iniciarDebug
        file = File.open("exemplo.txt")
        fileData = file.read
        fileData.chomp
        @txt = fileData
        file.close
    end

    def iniciarArquivo
        puts ("Digite o nome do arquivo txt a ser analisado. (NÃO DIGITE O \".txt\"). O arquivo deve estar junto ao código fonte.")
        fileName = gets.chomp()
        file = File.open(fileName+".txt")
        fileData = file.read
        fileData.chomp
        @txt = fileData
        file.close
    end

    def iniciarGets
        puts ("Digite o texto a ser analisado.")
        @txt = gets.chomp()
    end

    def separaCampos
        coisasDeDentro = ""
        
        result = @txt.scan(@geral)

        for item in result

            matchResult = item.match(@geralComNamedGrp)

            inicio = matchResult[:tipo]
            fim = matchResult[:fim]
            coisasDeDentro = item.match(@dentro)[0]

            dicionarioFormatado = initDict
            dicionarioFormatado["Endereco"] = ("Endereço: " + item)

            dicionarioFormatado["Tipo"] = ("Tipo: " + inicio)
            aux = coisasDeDentro.scan(@separaCampos)
            dicionarioFormatado["Nome"] = ("Nome: " + aux[0])
            aux.shift()
            

            if fim.match?(@cep)
                dicionarioFormatado["Cep"] = ("CEP: " + fim)
                ufOp = item.scan(@uf).last
                if ufOp != nil
                    dicionarioFormatado["Uf"] = ("UF: " + ufOp)
                end
            else
                dicionarioFormatado["Uf"] = ("UF: " + fim)
                cepOp = item.match(@cep)
                if cepOp != nil
                    dicionarioFormatado["Cep"] = ("CEP: " + cepOp[0])
                end
            end

            for buscaCep in aux
                buscaCep.gsub @cep, ''
            end

            for buscaUF in aux
                variavel = buscaUF.match(/\s[A-Z]{2}\s/)
                if variavel != nil
                    buscaUF[variavel[0]]= ""
                end
            end

            for buscaNumero in aux
                if buscaNumero.match?(@numero)
                    num = buscaNumero.match(@numero)[0]
                    dicionarioFormatado["Numero"] = ("Número: " + num)
                    buscaNumero.slice! num
                    break
                end
            end

            for elemento in aux
                variavel = elemento.match(/\s+/)
                if variavel != nil
                    aux.delete(variavel[0])
                end
            end
            aux.delete("")
        
            case aux.length
                when 1
                    dicionarioFormatado["Cidade"] = ("Cidade: " + aux[0])
                when 2
                    dicionarioFormatado["Complemento"] = ("Complemento: " + aux[0])
                    dicionarioFormatado["Cidade"] = ("Cidade: " + aux[1])    
                when 3
                    dicionarioFormatado["Complemento"] = ("Complemento: " + aux[0])    
                    dicionarioFormatado["Bairro"] = ("Bairro: " + aux[1])    
                    dicionarioFormatado["Cidade"] = ("Cidade: " + aux[2])        
                when 4
                    dicionarioFormatado["Complemento"] = ("Complemento: " + aux[1])    
                    dicionarioFormatado["Bairro"] = ("Bairro: " + aux[2])    
                    dicionarioFormatado["Cidade"] = ("Cidade: " + aux[3])  
                else
            end

            @vetorEnderecosFinal.append(dicionarioFormatado)
        end

        for enderco in @vetorEnderecosFinal
            printar enderco
        end
    end
end

e = Extrator.new
e.iniciar
e.separaCampos
