require 'sqlite3'
require 'system'

class StudyItems
  attr_accessor :title, :status, :category

  def initialize(title:, category: Category.new)
    @title = title
    @category = category
    @status = 'Em andamento'
  end

  def self.print_item(items)
    items.each do |item|
      puts "#%s - %s - %s - %s " % [ item['id'], item['title'], item['status'], item['category'] ]
    end

    puts "Nada para monstrar..." if items.empty?
    wait_and_clear
  end

  def self.not_concluded
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    studys = db.execute "SELECT id, title, status, category FROM studys WHERE status != 'Concluído'"
    db.close

    print_item(studys)
  end

  def self.only_concluded
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    studys = db.execute "SELECT id, title, status, category FROM studys WHERE status = 'Concluído'" 
    db.close

    print_item(studys)
  end

  def self.category_list(category)
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    studys = db.execute "SELECT id, title, status, category FROM studys WHERE category  LIKE '%#{category}%' COLLATE SQL_Latin1_General_CP1_CS_AS"
    db.close

    print_item(studys)
  end

  def insert
    db = SQLite3::Database.open "db/database.db"

    last_id = db.execute "SELECT id FROM studys ORDER BY id DESC LIMIT 1"
    last_id = last_id.join.to_i
    db.execute "INSERT INTO studys VALUES('#{ last_id + 1 }',  '#{ title }', '#{ status }', '#{ category }')"
    puts "Item criado com sucesso!"
    db.close
    self
  end

  def self.find_by_title(title)
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    studys = db.execute "SELECT id, title, status, category FROM studys WHERE title LIKE '%#{title}%' COLLATE SQL_Latin1_General_CP1_CS_AS"
    db.close

    print_item(studys)
  end

  def self.delete(id)
    db = SQLite3::Database.open "db/database.db"
    study = db.execute "DELETE FROM studys WHERE id = '#{id}'"
    puts "XXX Item deletado com sucesso! XXX" 
    db.close
    wait_and_clear
  end

  def self.change_status(id, new_status = 'Concluído')
    db = SQLite3::Database.open "db/database.db"
    study = db.execute "UPDATE studys SET status = '#{new_status}' WHERE id = '#{id}'"
    study = db.execute "SELECT title, category, status FROM studys WHERE id = '#{id}'"
    study.each {|el| print el}
    db.close
  end

  def self.wait_and_clear
    puts 'Pressione qualquer tecla para continuar...'
    STDIN.getc()
    system('clear')
  end
end