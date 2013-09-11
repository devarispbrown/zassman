class Asset < ActiveRecord::Base
  attr_accessible :box_link, :css, :invision_link, :name

  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true
end
