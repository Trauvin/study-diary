require './lib/study_items.rb'
require 'system'

CREATE = 1
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
  [#{CREATE}] Cadastrar item                      
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

def print_items(collection) 
  puts collection
  puts "Nenhum item encontrado!" if collection.empty?
end

def search_study_items
  print 'Digite a palavra para busca: '
  term = gets.chomp
  StudyItems.search(term)
end

def wait_and_clear
  puts 'Pressione qualquer tecla para continuar...'
  STDIN.getc()
  system('clear')
end

def update_status
  not_finalized = StudyItems.undone
  print_items(not_finalized)
  return if not_finalized.empty?

  print 'Digite o número que deseja finalizar: '
  index = gets.to_i
  not_finalized[index - 1].done!
end

def concluded
  concluded = StudyItems.done
  print_items(concluded)
end

opcao = menu
loop do 
  case opcao
  when CREATE
    StudyItems.create
  when SEE_NOT_CONCLUDED
    print_items(StudyItems.all)
  when FIND
    print_items(search_study_items)
  when DELETE
    
  when UPDATE_STATUS
    update_status
  when SEE_CONCLUDED
    concluded
  when LIST_BY_CATEGORY
      
  when EXIT
    break
    banner = 'figlet -c Ate mais ver'
    system(banner)
  else
    puts 'Opção inválida'
  end
  wait_and_clear
  opcao = menu
end


