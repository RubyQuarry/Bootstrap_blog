# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  content    :text
#  author     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  title      :string(255)
#  keywords   :text
#

class Blog < ActiveRecord::Base
  before_validation :update_keywords
  serialize :keywords, Array

  has_many :comments

  scope :search, -> (keyword) { where("keywords LIKE ?", "%#{keyword}%").where(published: true) }

  scope :inorder, -> { order('created_at DESC').where(published: true) }  # inorder

  validates :title, :author, :content, presence: true

  def self.all_keywords
    Blog.all.inject([]) do |n, m|
      n.concat(m.keywords)
    end.uniq
  end

  def self.archive_months
    Blog.inorder.map do |b|
      [b.created_at.month, b.created_at.year]
    end.uniq
  end


  protected

  def update_keywords
    if keywords_changed? and keywords.is_a?(String)
      self.keywords = self.keywords.split(',').collect(&:strip).map do |key|
        key.scan(/[a-zA-Z]/).join
      end
    end
  end
end
