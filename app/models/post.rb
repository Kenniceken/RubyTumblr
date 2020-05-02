class Post < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :delete_all
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image
  has_attached_file :image, style: { medium: "300x300>", thumb: "64x64>"  }
  has_attached_file :image, :default_url => ":style/missing_avatar.jpg", style: { medium: "300x300>", thumb: "50x50" }
  validates_attachment_content_type :image, content_type: /^image\/(png|gif|jpeg|jpg)/

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
