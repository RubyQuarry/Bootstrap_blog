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
  before_save :set_keywords
  serialize :keywords, Array

  scope :search, -> (keyword) { where("keywords LIKE ?", "%#{keyword}%") }

  scope :inorder, -> { order('created_at DESC') }

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

  def set_keywords
    self.keywords.map!(&:downcase)
  end
end
