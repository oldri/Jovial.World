class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_path, notice: "Blog post not found"
  end

  def index
    @blog_posts = BlogPost.order(created_at: :desc)
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = current_user.blog_posts.new(blog_post_params)

    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    unless @blog_post.user == current_user
      redirect_to root_path, alert: "You are not authorized to edit this post."
    end
  end

  def update
    if @blog_post.user == current_user
      if @blog_post.update(blog_post_params)
        redirect_to @blog_post
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: "You are not authorized to update this post."
    end
  end

  def destroy
    if @blog_post.user == current_user
      @blog_post.destroy
      redirect_to root_path
    else
      redirect_to root_path, alert: "You are not authorized to delete this post."
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  end
end
