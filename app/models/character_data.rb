class CharacterData < ActiveRecord::Base
  include CharacterRecognizer

  attr_accessible :character, :quadrants_quantity, :quadrants_attributes

  has_many :quadrants

  accepts_nested_attributes_for :quadrants
end
