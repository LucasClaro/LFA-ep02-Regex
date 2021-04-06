class Extrator

    def initialize
        @cep =  /\d{5}-?\d{3}/
        @uf = /(?<=[ ,-])[A-Z]{2}(?=[\s,-])/
        # @uf = /(?<=[ ,-])[A-Z]{2}(?=[^\w])/
        @tipoLogradouro = /(?:Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa)/
        @nomeDaRua = /(?<=Rua |Av |Av\. |Avenida |R |R\. |Rodovia |Praça |Travessa )[a-zA-Z0-9!\–º\(\)\-;':\\"\/\. ãáõôêéí]+(?=,)/
        # @numero = /(?<=(Rua |Av |Av\. |Avenida |R |R\. |Rodovia |Praça |Travessa )[a-zA-Z0-9!\–º\(\)\-;':\\"\/\. ãáõôêéí]{1,30})/
        @geral = /(?:Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa) [a-zA-Z0-9!\–º\(\)\-;':"\\,\/\. ãáõôêéí]{1,90} (?:[A-Z]{2}|\d{5}-?\d{3})/
        @geral3 = /(?<tipo>Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa) [a-zA-Z0-9!\–º\(\)\-;':"\\,\/\. ãáõôêéí]{1,90} (?<fim>[A-Z]{2}|\d{5}-?\d{3})/
        @txt = ""

        
        @dentro = /(?<=Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa) [a-zA-Z0-9!\–º\(\)\-;':"\\,\/\. ãáõôêéí]{1,90} (?=[A-Z]{2}|\d{5}-?\d{3})/
        @separaCampos = /(?:(?:\d\-\d)|(?:\d\-\d)|[a-zA-Z0-9!º\(\);':"\\\/\. ãáõôêéí]){1,}/
        @camposDeDentro = []

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

    def lerGeral
        enderecos = @txt.scan(@geral)
        for endereco in enderecos
            puts endereco
            lerEspecifico(endereco)
        end
    end

    def lerEspecificoCEP(endereco)
        endereco.scan(@cep)        
    end
    
    def lerEspecificoUF(endereco)
        endereco.scan(@uf)
    end

    def separaCampos
        coisasDeDentro = ""

        result = @txt.scan(@geral)
        for item in result

            matchResult = item.match(@geral3)

            inicio = matchResult[:tipo]
            fim = matchResult[:fim]
            # coisasDeDentro.append(item.match(@dentro)[0])
            coisasDeDentro = item.match(@dentro)[0]

            vetor = []
            vetor.append("Tipo: " + inicio)
            vetor += coisasDeDentro.scan(@separaCampos)
            
            if fim.match?(@cep)
                vetor.append("CEP: " + fim)
                ufOp = item.match(@uf)
                if ufOp != nil
                    vetor.append("UF: " + ufOp[0])
                end
            else
                vetor.append("UF: " + fim)
                cepOp = item.match(@cep)
                if cepOp != nil
                    vetor.append("CEP: " + cepOp[0])
                end
            end

            vetor.append(" ")
            @camposDeDentro.append(vetor)
        end

        # for item in coisasDeDentro

        #     vetor = item.scan(@separaCampos)
            
        #     cep = lerEspecificoCEP(item)
        #     uf = lerEspecificoUF(item)

        #     vetor.append(" ")
        #     @camposDeDentro.append(vetor)
        # end

        puts @camposDeDentro
    end
end

e = Extrator.new
e.iniciarDebug
# e.lerGeral
e.separaCampos
