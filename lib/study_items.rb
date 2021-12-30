require 'sqlite3'
require 'system'
require_relative 'category'

class StudyItems
  attr_reader :id, :title, :status, :category

  @@next_id = 1
  @@study_list = []
  def initialize(title:, category:)
    @id = @@next_id
    @title = title
    @category = category
    @done = false
    @@next_id += 1
  end

  def done?
    @done
  end

  def done!
    @done = true
  end

  def undone?
    !@done
  end

  def to_s
    "##{id} - #{title} - #{category}"
  end

  def include?(term)
    title.downcase.include? term.downcase
  end

  def self.create 
    print 'Digite o titulo do estudo: '
    title = gets.chomp
    print_items(Category.all)
    print 'Selecione a Categoria: '
    category = Category.index(gets.to_i - 1)
    puts "Item '#{title}' da categoria '#{category}' criado com sucesso."
    @@study_list << StudyItems.new(title: title, category: category)
  end

  def self.update_status
    not_finalized = StudyItems.undone
    print_items(not_finalized)
    return if not_finalized.empty?
  
    print 'Digite o id do item que deseja finalizar: '
    index = gets.to_i
    not_finalized[index - 1].done!
  end

  def self.search(term)
    all.filter {|element| element.include?(term)}
  end

  def self.delete
    element = search_by_id()
    if element
      all.delete(element)
      puts "#{element.id} - #{element.title} deletado!"
    else
      puts 'Item não encontrado!'
    end
  end

  def self.all
    @@study_list
  end
 
  def self.id_exists?(collection)
    print 'Digite o ID: '
    id = gets.to_i

    collection.each do |element|
      if element.id == id 
        return element
      end
    end
    return nil
  end

  def self.search_by_id
    id_exists?(all)
  end

  def self.undone
    all.filter(&:undone?)
  end

  def self.done
    all.filter(&:done?)
  end
end