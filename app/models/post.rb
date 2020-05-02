class Post < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :delete_all
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image
  has_attached_file :image, style: { medium: "300x300>", thumb: "64x64>"  }
  has_attached_file :image, :default_url => ":style/missing_avatar.jpg", style: { medium: "300x300>", thumb: "50x50" }
  validates_attachment_content_type :image, content_type: /^image\/(png|gif|jpeg|jpg)/

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
