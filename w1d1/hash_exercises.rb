class MyHashSet

  attr_accessor :store

  def initialize(set = {})
    @store = set
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store.has_key?(el)
  end

  def delete(el)
    if include?(el)
      @store.delete(el)
      return true
    else
      return false
    end
  end

  def to_a
    @store.keys
  end

  def union(set)
    return MyHashSet.new(@store.merge(set.store))
  end

  def intersect(set)
    intersection = {}
    @store.keys.each do |key|
      intersection[key] = true if set.include?(key)
    end

    return MyHashSet.new(intersection)
  end

  def minus(set)
    minus = {}
    @store.keys.each do |key|
      minus[key] = true if !set.include?(key)
    end

    return MyHashSet.new(minus)
  end

end

x = MyHashSet.new
p x
x.insert('a')
x.insert('b')
x.insert('c')
p x
p x.include?('c')
p x.include?('d')
p x.delete('b')
p x
p x.delete('d')
p x
p x.to_a
x.insert('b')
y = MyHashSet.new
y.insert('b')
y.insert('c')
y.insert('d')
p y
p x.union(y)
p x.intersect(y)
p x.minus(y)
