class Category
  attr_reader :title

  @@next_id = 1
  def initialize(title:)
    @id = @@next_id
    @title = title
    @@next_id += 1 
  end

  CATEGORIES = [
    new(title: 'Ruby'),
    new(title: 'Rails'),
    new(title: 'Javascript')
  ]

  def to_s 
    title
  end

  def self.all
    CATEGORIES
  end

  def self.index(number)
    CATEGORIES[number]
  end
end
