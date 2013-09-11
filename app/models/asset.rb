class Asset < ActiveRecord::Base
  attr_accessible :box_link, :css, :invision_link, :name

  validates :name, presence: true
end
