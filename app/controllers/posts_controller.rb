class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.create params[:post].permit(:title, :body, :image)
		@post.user = current_user
		
		redirect_to posts_path
	end
end