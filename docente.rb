require 'colorize'
require 'colorized_string'
class Docente
  @@docentes = []
  #attr_accessor :rut, :nombre, :apellido, :grado, :antiguedad, :horas, :atraso
  # def initialize
  
  # end

  def agregar(rut, nombre, apellido, grado, antiguedad, horas, atraso)
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
  end

  def calcular_sueldo(grado, antiguedad, horas, atraso)
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
    when 0...4                 #0...4  agregué un punto para excluir al 4  (rango menos de 4 años)
      aumentoPorAntiguedad = 3
    when 4..6
      aumentoPorAntiguedad = 4
    when 7..10
      aumentoPorAntiguedad = 5
    when 11..15
      aumentoPorAntiguedad = 7
    else
      aumentoPorAntiguedad = 10
    # when 16..100                    # 16..100
    #   aumentoPorAntiguedad = 10
    # else
    #   aumentoPorAntiguedad = 3
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
    # when 16..100
    #   bono = -40
    # else
    #   bono = 0
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
profesores.agregar("16.131.790-K", "Victor", "Arriagada", "Bachiller", 16 , 10, 0)          # B 16 10  0   560
profesores.agregar("17.131.790-K", "Eduardo", "Martinez", "Bachiller", 8, 20, 0)          #B   8 20  0   960
profesores.agregar("18.131.790-K", "Alberto", "Perez   ", "Doctorado", 3, 30, 5)             # D  3 30  5   6560

profesores.mostrar_docentes
profesores.mostrar_docentes "Bachiller"
profesores.mostrar_total_grado "Bachiller"
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