class Organization < ApplicationRecord


  validates :zip_code, length: { is: 6 }

  

  def self.search(search)
  	where(%q[ org_name LIKE :keyword OR country LIKE :keyword], :keyword=>"#{search}")
  end

end
