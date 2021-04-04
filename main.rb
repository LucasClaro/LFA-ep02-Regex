class Extrator

    def initialize
        @cep =  /\d{5}-?\d{3}/
        @uf = /(?<=[ ,-])[A-Z]{2}(?=[\s,-])/
        # @uf = /(?<=[ ,-])[A-Z]{2}(?=[^\w])/
        @tipoLogradouro = /(?:Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa)/
        @nomeDaRua = /(?<=Rua |Av |Av\. |Avenida |R |R\. |Rodovia |Praça |Travessa )[a-zA-Z0-9!\–º\(\)\-;':\\"\/\. ãáõôêéí]+(?=,)/
        @numero = /(?<=(?:Rua |Av |Av\. |Avenida |R |R\. |Rodovia |Praça |Travessa )[a-zA-Z0-9!\–º\(\)\-;':\\"\/\. ãáõôêéí]+)/

        @geral = /(?:Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa) [a-zA-Z0-9!\–º\(\)\-;':"\\,\/\. ãáõôêéí]{1,90} (?:[A-Z]{2}|\d{5}-?\d{3})/
        @txt = ""
      end
      attr_accessor :cep, :geral, :txt, :uf

    def iniciar
        file = File.open("exemplo.txt")
        fileData = file.read
        fileData.chomp
        @txt = fileData
        file.close
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
        numero = endereco.scan(@numero)
        puts numero
        puts
    end

end

e = Extrator.new
e.iniciar
e.lerGeral