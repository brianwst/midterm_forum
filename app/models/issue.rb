class Issue < ApplicationRecord
	validates_presence_of :title , :content
	belongs_to :user
	belongs_to :category
	has_many :comments , :dependent => :destroy
end
