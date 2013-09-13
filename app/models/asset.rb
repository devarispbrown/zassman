class Asset < ActiveRecord::Base
  attr_accessible :box_link, :css, :invision_link, :name, :image, :image_remote_url, :tag_list
  acts_as_taggable
  
  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true
  validates :tag_list, presence: true

  has_attached_file :image, styles: { medium: "320x240>"}
  validates_attachment :image, presence: true,
                            content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                            size: { less_than: 5.megabytes }

  searchable do
    text :name, :tag_list
  end

  def image_remote_url=(url_value)
    self.image = URI.parse(url_value) unless url_value.blank?
    super
  end
end
