# frozen_string_literal: true

def print_errors(resource)
  resource.errors.each do |error|
    color_code = 31
    print "\e[#{color_code}m#{"Error: #{error.attribute}: #{error.message}\n"}\e[0m"
  end
end

def attachable_io(path, folder = "#{Rails.root}/public/seeder/")
  { io: File.open("#{folder}#{path}"), filename: File.basename("#{folder}#{path}") }
end

if ENV['FILE'].blank?
  puts "No se especificó ningun archivo. Ejecuta el seeder de la siguiente manera:\n\n"
  puts "\trails db:seed FILE=*\t# Ejecuta todos los seeders"
  puts "\trails db:seed FILE=001\t# Ejecuta el seeder 001_*.rb\n\n"
else
  Dir["#{Rails.root}/db/seeds/#{ENV['FILE']}_*.rb"].sort.each do |file|
    puts "Ejecutando el arhivo '#{file}'"
    require file
  end
end