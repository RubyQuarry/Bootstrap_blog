# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  text       :text
#  name       :string(255)
#  email      :string(255)
#  vote       :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :blog

  validates :name, :text, presence: true
end
