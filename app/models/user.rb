class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # belongs_to :organization
  # validates :email, uniqueness: true

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
end
