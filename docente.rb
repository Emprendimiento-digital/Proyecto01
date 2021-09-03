class Docente
  @@docentes = []
  #attr_accessor :rut, :nombre, :apellido, :grado, :antiguedad, :horas, :atraso
  def initialize
  end

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
    when "Bachillerato"
      sueldoPorGrado = 40
    when "Titulado"
      sueldoPorGrado = 80
    when "Maestria"
      sueldoPorGrado = 100
    when "Doctorado"
      sueldoPorGrado = 180
    else
      sueldoPorGrado = 40
    end

    case antiguedad
    when 0..4
      aumentoPorAntiguedad = 3
    when 4..6
      aumentoPorAntiguedad = 4
    when 7..10
      aumentoPorAntiguedad = 5
    when 11..15
      aumentoPorAntiguedad = 7
    when 16..100
      aumentoPorAntiguedad = 10
    else
      aumentoPorAntiguedad = 3
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
    when 16..100
      bono = -40
    else
      bono = 0
    end
    #puts "horas: #{horas} - sueldoPorGrado: #{sueldoPorGrado} - aumentoPorAntiguedad: #{aumentoPorAntiguedad} - bono: #{bono}"
    (((horas * sueldoPorGrado) * (1 + (aumentoPorAntiguedad.to_f / 100))) + bono).to_i
  end

  def mostrar_docentes(grado = "all")
    puts "Rut\t\tNombre\t\tApellido\t\tGrado\t\tAntiguedad\tHoras\tAtraso\tSueldo"
    @@docentes.each {
      |docente|
      if grado == docente[:grado] || grado == "all"
        sueldo = calcular_sueldo docente[:grado], docente[:antiguedad], docente[:horas], docente[:atraso]
        puts "#{docente[:rut]}\t#{docente[:nombre]}\t\t#{docente[:apellido]}\t\t#{docente[:grado]}\t#{docente[:antiguedad]}\t\t#{docente[:horas]}\t#{docente[:atraso]}\t#{sueldo}"
      end
    }
  end

  def mostrar
    puts @@docentes
    puts
  end
end

profesores = Docente.new
#profesores.agregar(RUT,           NOMBRE,   APELLIDO,    GRADO ACADEMICO, ANTIGUEDAD, HORAS, ATRASOS)
profesores.agregar("16.131.790-K", "Victor", "Arriagada", "Bachillerato", 16, 10, 0)
profesores.agregar("17.131.790-K", "Eduardo", "Martinez", "Bachillerato", 8, 20, 0)
profesores.agregar("18.131.790-K", "Alberto", "Perez   ", "Doctorado", 3, 30, 5)

x = 0
case x
when 0
  profesores.mostrar_docentes
when 1
  profesores.mostrar_docentes "Bachillerato"
when 2
  profesores.mostrar_docentes "Titulado"
when 3
  profesores.mostrar_docentes "Maestria"
when 4
  profesores.mostrar_docentes "Doctorado"
end
