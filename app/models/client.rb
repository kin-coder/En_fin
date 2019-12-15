class Client < ApplicationRecord
  has_many :orders, dependent: :destroy # un client 1 ---- N  commande
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
