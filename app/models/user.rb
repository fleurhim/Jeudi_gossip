class User < ApplicationRecord
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" } 
	belongs_to :city
	has_many :gossips
	has_many :comments
	has_many :likes
	has_many :commentofcomments
	has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  	has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"
end
