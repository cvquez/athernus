# frozen_string_literal: true

ApplicationController.helpers.controllers_from_routes.each do |name, actions|
  actions.each do |action|
    Permission.find_or_create_by(controller: name, action: action) do |permission|
      puts "Creando el permiso '#{permission.controller}##{permission.action}'"
    end
  end
end
role = Role.find_or_create_by(name: 'Administradores') { |g| puts "Creando el rol '#{g.name}'" }

role.permissions = Permission.where.not(deleted: true)
role.save