class Docente
    @docentes = []
    def initialize rut, nombre, apellido, grado, antiguedad, horas, atrazo
        @docentes.push({
            rut: rut,
            nombre: nombre, 
            apellido: apellido, 
            grado: grado, 
            antiguedad: antiguedad, 
            horas: horas, 
            atrazo: atrazo
        })
    end
    def mostrar
        puts @docentes
    end
    
end

prof01 = Docente.new("12345678","Nom1","apell1","grado1","anti1","hora1","atr1")
prof01.mostrar
prof02 = Docente.new("22345678","Nom2","apell2","grado2","anti2","hora2","atr2")
prof02.mostrar
prof03 = Docente.new("32345678","Nom3","apell3","grado3","anti3","hora3","atr3")
prof03.mostrar
prof04 = Docente.new("42345678","Nom4","apell4","grado4","anti4","hora4","atr4")
prof04.mostrar
