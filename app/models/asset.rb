class Asset < ActiveRecord::Base
  attr_accessible :box_link, :css, :invision_link, :name, :image

  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true
  has_attached_file :image, styles: { medium: "320x240>"}
  validates_attachment :image, presence: true,
                            content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                            size: { less_than: 5.megabytes }
end
