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
  serialize :keywords, Array

  scope :search, ->(keyword) { where("keywords LIKE ?", "%#{keyword}%") }

  #TODO: add validations

  before_save :set_keywords


  def self.all_keywords
    Blog.all.inject([]) do |n, m|
      n.concat(m.keywords)
    end.uniq
  end

  protected

  def set_keywords
    self.keywords.map(&:downcase)
  end
end
