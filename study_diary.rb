require './lib/study_items.rb'
require 'system'
opcao = 0


while opcao != 7
  StudyItems.menu

  opcao = gets.to_i
  case opcao
  when 1
    puts "Digite o titulo do estudo: "
    title = gets.to_s.chomp
    puts "Digite a categoria do estudo: "
    category = gets.to_s.chomp

    e = StudyItems.new(title: title, category: category).save_to_db

  when 2
    StudyItems.all

  when 3
    puts "Digite o title que deseja buscar: "
    find_title = gets.to_s.chomp

    StudyItems.find_by_title(find_title)

  when 4
    puts 'Digite o ID do item que deseja excluir: '
    id = gets.to_i

    StudyItems.delete(id)

  when 5

  when 7
    banner = 'figlet -c Ate mais ver'
    system(banner)
  end
end


