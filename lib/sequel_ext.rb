require 'sequel'

class Sequel::Model
  def save *columns
    result = super
    id = pk
    result
  end

  def to_s
    values.to_s
  end

  def self.subclass_delete
    m = model
    m.cti_tables.reverse.each do |table|
      m.db.from(table).delete
    end
    self
  end

  def self.id json
    self.new.from_json(json).id
  end

  def self.existing json
    self[self.id json]
  end
end
