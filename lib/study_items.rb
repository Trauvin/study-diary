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
    |     [7] sair                        |
    |     Escolha uma opção:              |
    =======================================
    "            
  end

  def self.all
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    studys = db.execute "SELECT id, title, status, category FROM studys"
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
    db.close
  end
end