class Post < ApplicationRecord
  has_attached_file :photo, {styles: { small: "64x64", med: "100x100", large: "200x200"},
                  :url  => "/assets/photos/posts/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/photos/posts/:id/:style/:basename.:extension",
                  :default_url => "posts/default/:style/missing.png"}
  # validates :title, :content, presence: true
  # validates :title, length: {minimum: 5}
  # validates :content, length: {in: 5..254}
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  belongs_to :user
end
