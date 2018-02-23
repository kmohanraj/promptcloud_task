class Organization < ApplicationRecord
  has_many :users


  validates :zip_code, length: { is: 6 }
  validates :org_name, uniqueness: true

  # def self.search(search)
  #   # where("locality LIKE ?", "%#{search}%").having("properties.status = 1")
  #   where("org_name LIKE ?", "%#{search}%")
  # end

  def self.search(search)
  	where(%q[ org_name LIKE :keyword OR user.email LIKE :keyword OR country LIKE :keyword], :keyword=>"#{search}")
  end

end
