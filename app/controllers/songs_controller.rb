class SongsController < ApplicationController
	def index
		@songs = Song.all.order(adds: :desc)
	end

	def create
		@song = Song.new(song_params)
		if @song.save
			redirect_to "/songs"
		else
			flash[:errors] = ["Title and Artist must be at least 2 characters"]
			redirect_to "/songs"
		end
	end

	def add
		song1 = Song.find(params[:song_id])
		add = song1[:adds]
		add += 1
		song1[:adds] = add
		song1.save

	x = Playlist.where(user:User.find(session[:user_id]), song:Song.find(params[:song_id]))
	if x.first != nil
		song2 = Playlist.where(user:User.find(session[:user_id]), song:Song.find(params[:song_id]))
		adds2 = song2.first[:adds]
		adds2 += 1
		song2.first[:adds] = adds2
		song2.first.save
	else
		Playlist.create(user:User.find(session[:user_id]), song:Song.find(params[:song_id]), adds:1)
	end
		redirect_to "/songs"
	end

	def show
		@users = Song.find(params[:id]).song_adders
		@song = Song.find(params[:id])
	end

	private
	def song_params
		params.require(:song).permit(:title, :artist).merge(adds: 0)
	end
end
