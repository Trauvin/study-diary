require 'sqlite3'

class StudyItems
  attr_accessor :title, :status, :category

  def initialize(title:, status: 'Em andamento', category: Category.new)
    @title = title
    @status = status
    @category = category
  end

  def self.menu
    puts "
    =======================================
    |     [1] Cadastrar item              |
    |     [2] Ver items cadastrados       | 
    |     [3] Buscar item                 |
    |     [4] Deletar                     |
    |     [5] Atualizar status            |
    |     [6] Ver items concluídos        | 
    |     [7] Sair                        |
    |     Escolha uma opção:              |
    =======================================
    "            
  end

  def self.all
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    studys = db.execute "SELECT id, title, status, category FROM studys WHERE status != 'Concluído'"
    db.close

    studys.each do |study|
      puts " %s - %s - %s - %s " % [ study['id'], study['title'], study['status'], study['category'] ]
    end
  end

  def self.only_concluded
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    studys = db.execute "SELECT id, title, status, category FROM studys WHERE status = 'Concluído'"
    db.close

    studys.each do |study|
      puts " %s - %s - %s - %s " % [ study['id'], study['title'], study['status'], study['category'] ]
    end
  end

  def save_to_db
    db = SQLite3::Database.open "db/database.db"

    last_id = db.execute "SELECT id FROM studys ORDER BY id DESC LIMIT 1"
    last_id = last_id.join.to_i
    db.execute "INSERT INTO studys VALUES('#{ last_id + 1 }',  '#{ title }', '#{ status }', '#{ category }')"
    db.close
    self
  end

  def self.find_by_title(title)
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    studys = db.execute "SELECT title, status, category FROM studys where title='#{title}'"
    db.close
    studys.each do |study|
      puts "%s - %s - %s " % [ study['title'], study['status'], study['category'] ]
    end
  end

  def self.delete(id)
    db = SQLite3::Database.open "db/database.db"
    study = db.execute "DELETE FROM studys WHERE id = '#{id}'"
    puts "XXX Item deletado com sucesso! XXX" 
    db.close
  end

  def self.change_status(id, new_status = 'Concluído')
    db = SQLite3::Database.open "db/database.db"
    study = db.execute "UPDATE studys SET status = '#{new_status}' WHERE id = '#{id}'"
    study = db.execute "SELECT title, category, status FROM studys WHERE id = '#{id}'"
    study.each {|el| print el}
    db.close
  end
end