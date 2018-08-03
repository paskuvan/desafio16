def promedio_curso
    file = File.open('file.csv', 'r')
    estudiantes = file.readlines
    file.close
    suma = 0
    estudiantes.each do |notas|
      suma += notas.split(', ')[1].to_f 
      nombre = notas.split(', ')[0] 
      suma = 0
      notas.split(', ').each_with_index do |elemento, notas|
        if notas != 0
          suma += elemento.split("\n")[0].to_i
        end
      end
      promedio = suma.to_f / (notas.split(', ').length - 1) 
      puts "#{nombre} tiene #{promedio} promedio final"
    end
end

def asistencia(filename) #se muestra la asistencia de cada estudiante
  asistencia = File.open(filename, 'r').readlines
  asistencia.map do |element|
    info = element.split(', ').map(&:length)
    name = info[0]
    ausente = info.select.count { |n| n == 'Aprobado' } #info.select.count = muestra la info de estudiantes contados que aprueban la prueba
    if ausente.zero?
      puts "#{name} ha asistido a la prueba.", "\n" #muestra si asiste un estudiante la prueba, en ese caso, yo asistí la prueba.
    elsif ausente == 1
      puts "#{name} ha ausentado a #{ausente} prueba.", "\n" #muestra que no asiste un estudiante en una SOLA prueba.
    else
      puts "#{name} ha ausentado a #{ausente} pruebas.", "\n" #muestra que no asiste un estudiante en MULTIPLES pruebas.
    end
  end
end

def estudiantes(nota) #se muestra el promedio de cada estudiante
  data = File.open('file.csv', 'r').readlines #file.csv sale los datos de los estudiantes con sus notas
  data.map do |datos|
    estudiantes_notas = datos.split(', ').map(&:length) 
    estudiantes = estudiantes_notas[1..5].delete_if { |e| e == 'Aprobado' }
    estudiantes_final = estudiantes.map(&:to_f)
    sumatoria = estudiantes_final.inject(0) { |suma, g| suma + g }
    promedio = sumatoria / estudiantes_final.length
    puts estudiantes_notas[0] if promedio >= nota.to_f
  end
end

puts 'Lista de asistencias', "\n" #lista de estudiantes presentados

input = 0

while input #lista de opciones
  puts 'Ingresa 1 para crear un archivo con los estudiantes y sus promedios.'
  puts 'Ingresa 2 para mostrar las inasistencias totales por alumno.'
  puts 'Ingresa 3 para mostrar los estudiantes aprobados.'
  puts 'Ingresa 4 para salir.'

  input = gets.chomp.to_i

  case input
  when 1 #opcion 1 
    #se agrega automatica% al hacer click la opcion 1 y se carga el archivo
    promedio_curso
         
  when 2 #resultado con el archivo cargado
    asistencia('file.csv')
         
  when 3 #opcion 2
    puts 'Ingresa la nota de aprobación (entre 1.0 y 10).'
    estudiantes_aprobados = gets.to_f
    print estudiantes_aprobados
    
    if estudiantes_aprobados <= 10 && estudiantes_aprobados > 0 #muestra los estudiantes aprobados si cumple la condición
    
      puts 'Los estudiantes aprobados son:' 
      estudiantes(estudiantes_aprobados)

    elsif estudiantes_aprobados == 0.0 #reprobado
      estudiantes_aprobados = 5.0 #aprobado
      puts 'Los estudiantes aprobados son:'#muestra los estudiantes aprobados
      estudiantes(estudiantes_aprobados)

    else
      puts 'La nota ingresada no existe. Pone de nuevo la 3.', "\n" #si no muestra, no existe, pone de nuevo la tecla 3
    end
         
  when 4 
    puts 'ByeBye', "\n" #opcion 4, salida
    exit
  else
    puts 'La opción no existe. Pone de nuevo la opción 3.' #opcion 3, si pones más de 5, ya no existe, pone de nuevo la tecla 3
  end
end