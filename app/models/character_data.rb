class CharacterData < ActiveRecord::Base
  attr_accessible :character, :quadrants_quantity, :quadrants_attributes

  has_many :quadrants

  accepts_nested_attributes_for :quadrants

  def to_s
    character
  end
end
