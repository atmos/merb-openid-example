class User
  include DataMapper::Resource

  property :id, Serial
  property :name,         String, :nullable => false, :unique => true, :unique_index => true
  property :email,        String, :nullable => false, :unique => true, :unique_index => true
  property :identity_url, String, :nullable => false, :unique => true, :unique_index => true
 
  validates_format :email, :as => :email_address
  def password_required?; false end
end
