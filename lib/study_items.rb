require 'sqlite3'
require 'system'
require_relative 'category'

class StudyItems
  attr_reader :id, :title, :status, :category

  @@next_id = 1
  @@study_list = []
  def initialize(title:, category: Category.new)
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

  def self.all
    @@study_list
  end

  def self.search(term)
    all.filter {|element| element.include?(term)}
  end

  def self.undone
    all.filter(&:undone?)
  end

  def self.done
    all.filter(&:done?)
  end

end