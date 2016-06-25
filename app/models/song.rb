class Song < ActiveRecord::Base
	has_many :playlists
	has_many :song_adders, through: :playlists, source: :user

	validates :title, :artist, presence:true
end
