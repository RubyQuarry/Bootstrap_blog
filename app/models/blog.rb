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

  has_many :comments, dependent: :destroy #destroy comments on blog destroy

  scope :search, -> (keyword) { where("keywords LIKE ?", "%#{keyword}%") }

  scope :published, -> { where(published: true) }

  scope :inorder, -> { order('created_at DESC') }  # inorder

  scope :monthly, ->(month) { where(created_at: month.all_month) }

  validates :title, :author, :content, presence: true


  # class methods
  class << self

    def all_keywords
      Blog.inorder.published.inject([]) do |n, m|
        n.concat(m.keywords)
      end.uniq
    end

    def archive_months
      Blog.inorder.published.map do |b|
        [b.created_at.month, b.created_at.year]
      end.uniq
    end

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
