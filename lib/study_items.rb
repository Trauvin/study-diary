require 'sqlite3'
require 'system'

class StudyItems
  attr_accessor :id, :title, :status, :category

  def initialize(id:nil, title:, category: Category.new)
    @id = id
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

  def self.insert
    db = SQLite3::Database.open "db/database.db"

    print "Digite o titulo do estudo: "
    title = gets.to_s.chomp
    print "Digite a categoria do estudo: "
    category = gets.to_s.chomp

    e = StudyItems.new(title: title, category: category)

    db.execute <<~SQL, title, category, 'Em andamento' 
      INSERT INTO studys (title, category, status)
      VALUES (?, ?, ?)
    SQL

    puts "Item #{title} criado com sucesso!"
  ensure
    db.close if db
  end

  def self.find_by_title(title)
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    studys = db.execute "SELECT id, title, status, category FROM studys WHERE title LIKE '%#{title}%' COLLATE SQL_Latin1_General_CP1_CS_AS"
    db.close

    print_item(studys)
  end
  
  def self.find_by_id(id)
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    item = db.execute "SELECT * from studys WHERE id = '#{id}'"
    db.close
    print_item(item)
  end

  def self.delete(id)
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true

    study = db.execute "DELETE FROM studys WHERE id = '#{id}'"
    puts "XXX Item deletado com sucesso! XXX" 
    db.close
    wait_and_clear
  end

  def self.change_status
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true

    print 'Digite o ID do estudo terminado: '
    id = gets.to_i

    study = db.execute "UPDATE studys SET status = 'Concluído' WHERE id = '#{id}'"
    db.close
  end

  def self.wait_and_clear
    puts 'Pressione qualquer tecla para continuar...'
    STDIN.getc()
    system('clear')
  end
end