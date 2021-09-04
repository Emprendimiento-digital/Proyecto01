require "colorize"
require "colorized_string"

class Docente
  @@docentes = []
  #attr_accessor :rut, :nombre, :apellido, :grado, :antiguedad, :horas, :atraso
  # def initialize

  # end
  def validar_rut(rut)
    rutIngresado = rut.split("-")[0].gsub(".", "").to_i
    digitoVerificadorIngresado = rut.split("-")[1].strip
    #puts rutIngresado, digitoVerificadorIngresado
    #puts digito_verificador(rutIngresado)
    if digito_verificador(rutIngresado).to_i == digitoVerificadorIngresado.to_i
      true
    else
      false
    end
  end

  def digito_verificador(rut)
    [*0..9, "K"][rut.to_s.reverse.chars.inject([0, 0]) { |(i, a), n| [i + 1, a - n.to_i * (i % 6 + 2)] }[1] % 11]
  end

  def agregar(rut, nombre, apellido, grado, antiguedad, horas, atraso)
    if validar_rut rut
      @@docentes.push({
        rut: rut,
        nombre: nombre,
        apellido: apellido,
        grado: grado,
        antiguedad: antiguedad,
        horas: horas,
        atraso: atraso,
      })
      self
    else
      puts "Ingrese un RUT valido".colorize(:red)
    end
  end

  def calcular_sueldo(grado, antiguedad, horas, atraso)
    if grado != "Bachiller" && grado != "Titulado" && grado != "Maestría" && grado != "Doctorado"
      grado = "Bachiller"
    end
    if antiguedad < 0
      antiguedad = 0
    end
    if horas < 0
      horas = 0
    end
    if atraso < 0
      atraso = 0
    end
    case grado
    when "Bachiller"
      sueldoPorGrado = 40
    when "Titulado"
      sueldoPorGrado = 80
    when "Maestría"
      sueldoPorGrado = 100
    when "Doctorado"
      sueldoPorGrado = 180
    else
      sueldoPorGrado = 40
    end

    case antiguedad
    when 0...4 #0...4  agregué un punto para excluir al 4  (rango menos de 4 años)
      aumentoPorAntiguedad = 3
    when 4..6
      aumentoPorAntiguedad = 4
    when 7..10
      aumentoPorAntiguedad = 5
    when 11..15
      aumentoPorAntiguedad = 7
    else
      aumentoPorAntiguedad = 10
    end

    case atraso
    when 0
      bono = 120
    when 1..5
      bono = 80
    when 6..10
      bono = 40
    when 11..15
      bono = 0
    else
      bono = -40
    end
    #puts "horas: #{horas} - sueldoPorGrado: #{sueldoPorGrado} - aumentoPorAntiguedad: #{aumentoPorAntiguedad} - bono: #{bono}"
    (((horas * sueldoPorGrado) * (1 + (aumentoPorAntiguedad.to_f / 100))) + bono).to_i
  end

  def mostrar_docentes(grado = "all")
    puts ""
    if grado == "all"
      puts "\t      LISTADO  DE  TODOS  LOS  DOCENTES  CON  SUS  DATOS  Y  RESPECTIVO  SUELDO".colorize(:yellow)
      puts "    Rut\t\tNombre\t\t Apellido\t  Grado\t\tAntigüedad\tHoras\tAtraso\tSueldo".colorize(:yellow)
    else
      puts "\t     LISTADO  DE  DOCENTES  CON  GRADO  DE  #{grado.upcase}  CON  SUS  DATOS  Y  SUELDO".colorize(:magenta)
      puts "    Rut\t\tNombre\t\t Apellido\t  Grado\t\tAntigüedad\tHoras\tAtraso\tSueldo".colorize(:magenta)
    end
    @@docentes.each {
      |docente|
      if grado == docente[:grado] || grado == "all"
        sueldo = calcular_sueldo docente[:grado], docente[:antiguedad], docente[:horas], docente[:atraso]
        puts "#{docente[:rut]}\t#{docente[:nombre]}\t\t#{docente[:apellido]}\t#{docente[:grado]}\t    #{docente[:antiguedad]}\t\t  #{docente[:horas]}\t  #{docente[:atraso]}\t #{sueldo}"
      end
    }
    puts ""
    puts ""
  end

  def mostrar_total_grado(grado)
    sueldo_total_grado = 0
    puts "LISTADO DE SUELDOS DE #{grado.upcase}".colorize(:green)
    puts "  Grado\t\t\tSueldo".colorize(:green)
    @@docentes.each {
      |docente|
      if grado == docente[:grado]
        sueldo_total_grado += calcular_sueldo docente[:grado], docente[:antiguedad], docente[:horas], docente[:atraso]
      end
    }
    puts "#{grado}\t\t #{sueldo_total_grado}"           # .colorize(:light_blue)
    puts ""
    puts ""
  end

  def mostrar_4_grados
    sueldo_grados = []
    grados = ["Bachiller", "Titulado", "Maestría", "Doctorado"]
    puts "LISTADO DE SUELDOS POR GRADO Y TOTAL".colorize(:red)
    puts "  Grado\t\t\tSueldo".colorize(:red)
    # for i in 0...to grados.length do {
    (0...grados.length).each do |i|
      sum = 0
      @@docentes.each {
        |docente|
        if grados[i] == docente[:grado]
          sum += calcular_sueldo docente[:grado], docente[:antiguedad], docente[:horas], docente[:atraso]
        end
      }
      sueldo_grados.push(sum)
      puts "#{grados[i]}\t\t #{sueldo_grados[i]}"         # .colorize(:light_red)
    end
    puts "\tTotal Sueldos\t #{sueldo_grados.sum}".colorize(:red)
    puts ""
  end

  # def mostrar_4_grados
  #   sueldo_grados = []
  #   grados = ["Bachiller", "Titulado", "Maestría", "Doctorado"]
  #   puts "Grado\t\t\tSueldo"
  #   for i in 0...to grados.length do{
  #     @@docentes.each {
  #       |docente|
  #       if grados[i] == docente[:grado]
  #         sueldo_total_grado += calcular_sueldo docente[:grado], docente[:antiguedad], docente[:horas], docente[:atraso]
  #       end
  #     }
  #    }

  #   puts "#{grado}\t\t\t#{sueldo_grados}"
  # end

  def mostrar
    puts @@docentes
  end
end

profesores = Docente.new
#profesores.agregar(RUT,           NOMBRE,   APELLIDO,    GRADO ACADEMICO, ANTIGUEDAD, HORAS, ATRASOS)
# profesores.agregar("16.131.790-9", "Victor", "Arriagada", "Bachiller", 16, 10, 0)          # B 16 10  0   560
# profesores.agregar("16.131.790-1", "Eduardo", "Martinez", "Bachiller", 8, 20, 0)          #B   8 20  0   960
# profesores.agregar("16.131.790-0", "Alberto", "Perez   ", "Doctorado", 3, 30, 5)             # D  3 30  5   6560

profesores.agregar("19.181.537-8", "Ana", "Abrigo   ", "Doctorado", 6, 180, 0)
profesores.agregar("20.780.273-5", "Olga", "Acevedo   ", "Titulado", 20, 150, 0)
profesores.agregar("19.364.953-k", "Jorge", "Alvarez   ", "Maestría", 16, 150, 0)
profesores.agregar("5.558.904-6", "Walter", "Andrade   ", "Bachiller", 5, 150, 0)
profesores.agregar("23.985.117-7", "Jaime", "Arancibia   ", "Doctorado", 90, 30, 5)
profesores.agregar("17.165.338-k", "Omar", "Aranda   ", "Titulado", 8, 80, 0)
profesores.agregar("13.671.510-0", "Aquiles", "Araya   ", "Maestría", 15, 90, 0)
profesores.agregar("23.237.758-5", "Luis", "Araya   ", "Doctorado", 18, 180, 15)
profesores.agregar("19.275.494-1", "Victor", "Ayala   ", "Bachiller", 11, 150, 15)
profesores.agregar("6.532.994-8", "Jose", "Gonzalez   ", "Titulado", 4, 90, 0)
profesores.agregar("12.623.274-8", "Dora", "Fuentes   ", "Maestría", 1, 10, 0)
profesores.agregar("23.081.919-k", "Luis", "Navarro   ", "Bachiller", 13, 30, 0)
profesores.agregar("7.390.911-2", "Claudia", "Herrera   ", "Doctorado", 7, 30, 0)
profesores.agregar("21.720.095-4", "Jose", "Padilla   ", "Titulado", 10, 45, 25)
profesores.agregar("10.955.633-5", "Luis", "Roman   ", "Maestría", 2, 20, 15)
profesores.agregar("6.679.939-5", "Sofia", "Espinoza   ", "Bachiller", 19, 30, 5)
profesores.agregar("13.761.232-1", "Teresa", "Dominguez   ", "Doctorado", 12, 180, 5)
profesores.agregar("22.980.062-0", "Jorge", "Bravo   ", "Titulado", 17, 150, 0)
profesores.agregar("6.506.206-2", "Ana", "Bustos   ", "Titulado", 3, 180, 0)
profesores.agregar("21.041.601-3", "Hilda", "Calderon   ", "Titulado", 1, 30, 0)

profesores.mostrar_docentes
profesores.mostrar_docentes "Bachiller"
profesores.mostrar_docentes "Titulado"
profesores.mostrar_docentes "Maestría"
profesores.mostrar_docentes "Doctorado"
profesores.mostrar_total_grado "Bachiller"
profesores.mostrar_total_grado "Titulado"
profesores.mostrar_total_grado "Maestría"
profesores.mostrar_total_grado "Doctorado"
profesores.mostrar_4_grados

# x = 0
# case x
# when 0
# when 1
#   profesores.mostrar_docentes "Bachiller"
# when 2
#   profesores.mostrar_docentes "Titulado"
# when 3
#   profesores.mostrar_docentes "Maestría"
# else
#   profesores.mostrar_docentes "Doctorado"
# end
# profesores.mostrar

# ColorizedString.colors                       # return array of all possible colors names
# ColorizedString.modes                        # return array of all possible modes
# ColorizedString.color_samples
