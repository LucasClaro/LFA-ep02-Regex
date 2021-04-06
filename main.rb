class Extrator

    def initialize
        @cep =  /\d{5}-?\d{3}/
        @uf = /(?<=[ ,-])[A-Z]{2}(?=[\s,-])/
        # @uf = /(?<=[ ,-])[A-Z]{2}(?=[^\w])/
        @tipoLogradouro = /(?:Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa)/
        @nomeDaRua = /(?<=Rua |Av |Av\. |Avenida |R |R\. |Rodovia |Praça |Travessa )[a-zA-Z0-9!\–º\(\)\-;':\\"\/\. ãáõôêéí]+(?=,)/
        # @numero = /(?<=(Rua |Av |Av\. |Avenida |R |R\. |Rodovia |Praça |Travessa )[a-zA-Z0-9!\–º\(\)\-;':\\"\/\. ãáõôêéí]{1,30})/
        @geral = /(?:Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa) [a-zA-Z0-9!\–º\(\)\-;':"\\,\/\. ãáõôêéí]{1,90} (?:[A-Z]{2}|\d{5}-?\d{3})/
        @txt = ""

        
        @dentro = /(?<=Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa) [a-zA-Z0-9!\–º\(\)\-;':"\\,\/\. ãáõôêéí]{1,90} (?=[A-Z]{2}|\d{5}-?\d{3})/
        @separaCampos = /[a-zA-Z0-9!º\(\);':"\\\/\. ãáõôêéí]{1,}/
        @camposDeDentro = []

    end
    attr_accessor :cep, :geral, :txt, :uf

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

    def lerEspecifico(endereco)
        cep = endereco.scan(@cep)
        uf = endereco.scan(@uf).last
        tipoLogradouro = endereco.scan(@tipoLogradouro).first
        nomeDaRua = endereco.scan(@nomeDaRua)
        # numero = endereco.scan(@numero)
        # puts numero
        puts
    end

    def separaCampos
        coisasDeDentro = []

        result = @txt.scan(@geral)
        for item in result
            coisasDeDentro.append(item.match(@dentro)[0])
        end

        for item in coisasDeDentro
            @camposDeDentro.append(item.scan(@separaCampos))
        end

        puts @camposDeDentro
    end
end

e = Extrator.new
e.iniciar
# e.lerGeral
e.separaCampos
