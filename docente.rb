class Docente
  @@docentes = []
  attr_accessor :rut, :nombre, :apellido, :grado, :antiguedad, :horas, :atraso

  def initialize
    @rut = rut
    @nombre = nombre
    @apellido = apellido
    @grado = grado
    @antiguedad = antiguedad
    @horas = horas
    @atraso = atraso
    # @docentes.push({
    #     rut: rut,
    #     nombre: nombre,
    #     apellido: apellido,
    #     grado: grado,
    #     antiguedad: antiguedad,
    #     horas: horas,
    #     atraso: atraso
    # })
  end

  def agregar(rut, nombre, apellido, grado, antiguedad, horas, atraso)
    # @docentes.push()

    @@docentes.push({ e: rut, f: nombre })
    self
  end

  def mostrar
    puts @@docentes
  end
end

prof01 = Docente.new
prof01.agregar("12345678", "Nom1", "apell1", "grado1", "anti1", "hora1", "atr1")
prof02 = Docente.new
prof02.agregar("22345678", "Nom2", "apell1", "grado1", "anti1", "hora1", "atr1")
prof03 = Docente.new
prof03.agregar("32345678", "Nom2", "apell1", "grado1", "anti1", "hora1", "atr1")

prof01.mostrar

#prof02 = Docente.new("22345678","Nom2","apell2","grado2","anti2","hora2","atr2")
# prof02.mostrar
# prof03 = Docente.new("32345678","Nom3","apell3","grado3","anti3","hora3","atr3")
# prof03.mostrar
# prof04 = Docente.new("42345678","Nom4","apell4","grado4","anti4","hora4","atr4")
# prof04.mostrar
# {
#     rut: @rut,
#     nombre: @nombre,
#     apellido: @apellido,
#     grado: @grado,
#     antiguedad: @antiguedad,
#     horas: @horas,
#     atraso: @atraso,
#   }
