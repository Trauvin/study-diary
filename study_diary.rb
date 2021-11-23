require './lib/study_items.rb'
require 'system'

REGISTER = 1
SEE_NOT_CONCLUDED = 2
FIND = 3
DELETE = 4
UPDATE_STATUS = 5
SEE_CONCLUDED = 6
LIST_BY_CATEGORY = 7
EXIT = 8

def menu
  puts <<~MENU
  =======================================
  [#{REGISTER}] Cadastrar item                      
  [#{SEE_NOT_CONCLUDED}] Ver items cadastrados               
  [#{FIND}] Buscar item                         
  [#{DELETE}] Deletar                            
  [#{UPDATE_STATUS}] Atualizar status                    
  [#{SEE_CONCLUDED}] Ver items concluídos               
  [#{LIST_BY_CATEGORY}] Listar por categoria   
  [#{EXIT}] Sair                          
  ========================================
  MENU
  print "\n Escolha uma opção: "
  gets.to_i         
end

opcao = 0


while opcao != EXIT
  opcao = menu()

  case opcao
  when REGISTER
    print "Digite o titulo do estudo: "
    title = gets.to_s.chomp
    print "Digite a categoria do estudo: "
    category = gets.to_s.chomp

    e = StudyItems.new(title: title, category: category).insert

  when SEE_NOT_CONCLUDED
    StudyItems.not_concluded

  when 3
    print "Digite o title que deseja buscar: "
    title = gets.to_s.chomp

    StudyItems.find_by_title(title)
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


