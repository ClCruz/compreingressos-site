# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

puts "Adicionando usuário padrão..."
if Usuario.count < 1
  u = Usuario.new(:nome => "faro", :senha => "F4r0")
  puts u.save ? "Usuário padrão adicionado!\nUSER: faro\nPASS: F4r0\n\n" : "Erro: Não foi possível adicionar usuário padrão\n\n"
else
  puts "Erro: Já existem usuários cadastrados\n\n"
end