# frozen_string_literal: true

role = Role.find_or_create_by(name: 'Administradores') { |g| puts "Creando el rol '#{g.name}'" }

role.permissions = Permission.where.not(deleted: true)
role.save

admin = Admin.find_or_create_by(username: 'admin') do |user|
  user.email = 'admin@admin.com'
  user.password = 'Admin.123'
  user.password_confirmation = 'Admin.123'
  user.role = role
  puts "Creando el admin '#{user.username}'"
end

print_errors admin

