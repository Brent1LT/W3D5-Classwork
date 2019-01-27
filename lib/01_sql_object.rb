require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
   @cols ||= DBConnection.execute2(<<-SQL)
  SELECT
    *
  FROM
    #{table_name}
  SQL

  
  @columns = @cols[0].map {|col| col.to_sym}
  end

  def self.finalize!
    
    columns.each do |col|
      define_method("#{col}") do 
        attributes[col]
      end 

      define_method("#{col}=") do |val|
        attributes[col] = val
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
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |k,v|
      if @attributes.keys.include?(k)
        send()
      end 
    end 
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
