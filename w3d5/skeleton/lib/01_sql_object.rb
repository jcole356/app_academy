require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    DBConnection.execute2(<<-SQL).first.map(&:to_sym)
      SELECT
        *
      FROM
        cats
    SQL
  end

  def self.finalize!
    self.columns.each do |column|
      column_s = column.to_s

      define_method("#{column_s}=") do |val|
        attributes[column] = val
      end

      define_method("#{column_s}") do
        attributes[column]
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    self.parse_all(results)
  end

  def self.parse_all(results)
    results.map do |params|
      self.new(params)
    end
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = ?
    SQL

    return nil if results.empty?
    self.new(results[0])
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name_sym = attr_name.to_sym

      unless self.class.columns.include?(attr_name_sym)
        raise "unknown attribute '#{attr_name}'"
      end

      send("#{attr_name_sym}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |attr_name|
      attr_name_sym = attr_name.to_sym
      send(attr_name_sym)
    end
  end

  def insert
    col_names = self.class.columns.map(&:to_s).join(", ")
    n = self.class.columns.count
    question_marks = []
    n.times { question_marks << "?" }
    question_marks = question_marks.join(", ")

    DBConnection.execute(<<-SQL, attribute_values)
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
      (#{question_marks})
    SQL
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
