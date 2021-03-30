class Extrator

    @cep =  /\d{5}-?\d{3}/
    @geral = /(Rua|Av|Av\.|Avenida|R|R\.|Rodovia|Praça|Travessa) [a-zA-Z0-9!–º()\-;':"\\|,\/. ãôéí]{1,90} ([A-Z]{2}|\d{5}-?\d{3})/

    @txt = ""

    def iniciar
        file = File.open("exemplo.txt")
    end

end


