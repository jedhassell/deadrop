class Drop
  include Mongoid::Document
  index :drop, unique: true
end