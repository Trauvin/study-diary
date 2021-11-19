require './lib/study_items.rb'
require 'system'
opcao = 0

while opcao != 8
  StudyItems.menu

  opcao = gets.to_i
  case opcao
  when 1
    print "Digite o titulo do estudo: "
    title = gets.to_s.chomp
    print "Digite a categoria do estudo: "
    category = gets.to_s.chomp

    e = StudyItems.new(title: title, category: category).save_to_db

  when 2
    StudyItems.all

  when 3
    print "Digite o title que deseja buscar: "
    find_title = gets.to_s.chomp

    StudyItems.find_by_title(find_title)

  when 4
    print 'Digite o ID do item que deseja excluir: '
    id = gets.to_i

    StudyItems.delete(id)

  when 5
    print 'Digite o ID do estudo terminado: '
    id = gets.to_i

    StudyItems.change_status(id)
    
  when 6
    StudyItems.only_concluded

  when 7
    print 'Digite a categoria que deseja listar: '
    category = gets.to_s.chomp
    StudyItems.category_list(category)
    
  when 8
    banner = 'figlet -c Ate mais ver'
    system(banner)
  end
end


