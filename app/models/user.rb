class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :nullable => false
  property :email, String, :nullable => false
  property :identity_url, String, :nullable => false

  validates_is_unique :identity_url
  validates_is_unique :name
  validates_is_unique :email
  def password_required?; false end
end
