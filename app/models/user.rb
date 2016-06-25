class User < ActiveRecord::Base
  has_secure_password
  has_many :songs
  has_many :playlists
  has_many :songs_added, through: :playlists, source: :song

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, presence:true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, presence:true, on: :create
end
