class UsersController < ApplicationController
	def index
	end

	def create
		@user = User.new(user_params)
		if @user.save
			puts "\n\n\n\n\n\ user was saved\n\n\n\n\n\n"
			redirect_to "/"
		else
			puts "\n\n\n\n\n\ user was not saved\n\n\n\n\n\n"
			flash[:errors] = @user.errors.full_messages
			redirect_to "/"
		end
	end

def login
		@user = User.find_by_email(params[:email])
		if @user and @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect_to "/songs"
		else
			flash[:errors] = ["Email or password did not match our records"]
			redirect_to "/"
		end
	end

def logout
	session.clear
	redirect_to "/"
end

def show
	@user = User.find(params[:id])
	@songs = @user.songs_added
end

private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password)
	end
end
