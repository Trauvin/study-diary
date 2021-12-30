require './lib/study_items.rb'
require 'system'

CREATE = 1
SEE_NOT_CONCLUDED = 2
FIND = 3
DELETE = 4
UPDATE_STATUS = 5
SEE_CONCLUDED = 6
LIST_BY_CATEGORY = 7
SEARCH_BY_ID = 8
ADD_CATEGORY = 9
EXIT = 10

def menu
  puts <<~MENU
  =======================================
  [#{CREATE}] Cadastrar item                      
  [#{SEE_NOT_CONCLUDED}] Ver items cadastrados               
  [#{FIND}] Buscar item                         
  [#{DELETE}] Deletar                            
  [#{UPDATE_STATUS}] Atualizar status                    
  [#{SEE_CONCLUDED}] Ver items concluídos               
  [#{LIST_BY_CATEGORY}] Listar por categoria
  [#{SEARCH_BY_ID}] Busca por ID
  [#{ADD_CATEGORY}] Criar nova categoria  
  [#{EXIT}] Sair                          
  ========================================
  MENU
  print "\n Escolha uma opção: "
  gets.to_i         
end

def print_items(collection) 
  puts collection
  puts "Nenhum item encontrado!" if collection.empty?
end

def search_study_items
  print 'Digite a palavra para busca: '
  term = gets.chomp
  StudyItems.search(term)
end

def list_by_category
  category = Category.all
  print_items(category)
  print 'Selecione o id categoria que deseja listar: '
  id_category = gets.to_i
  items = StudyItems.all
  
  items.each do |item|
    if item.category.id == id_category
      puts item
    end
  end
end

def wait_and_clear
  puts 'Pressione qualquer tecla para continuar...'
  STDIN.getc()
  system('clear')
end

opcao = menu
loop do 
  case opcao
  when CREATE
    StudyItems.create
  when SEE_NOT_CONCLUDED
    print_items(StudyItems.undone)
  when FIND
    print_items(search_study_items)
  when DELETE
    StudyItems.delete
  when UPDATE_STATUS
    StudyItems.update_status
  when SEE_CONCLUDED
    print_items(StudyItems.done)
  when LIST_BY_CATEGORY
    list_by_category
  when SEARCH_BY_ID
    StudyItems.search_by_id
  when ADD_CATEGORY
    Category.new
  when EXIT
    banner = 'figlet -c Ate mais ver'
    system(banner)
    break
  else
    puts 'Opção inválida'
  end
  wait_and_clear
  opcao = menu
end


