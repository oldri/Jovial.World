class BlogPostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_path, notice: "Blog post not found"
  end

  def index
    @blog_posts = BlogPost.where(visibility: 'public').published.order(published_at: :desc)
  end
  
  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = current_user.blog_posts.new(blog_post_params)
  
    if @blog_post.visibility == 'draft'
      @blog_post.published_at = nil
    else
      @blog_post.published_at ||= Date.today
    end
  
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      if @blog_post.visibility == 'draft'
        @blog_post.update(published_at: nil)
      else
        @blog_post.update(published_at: Date.today) if @blog_post.published_at.nil?
      end
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    flash[:notice] = "Blog post was successfully deleted."
    redirect_to root_path
  end

  def like
    toggle_like(:liked)
  end

  def unlike
    toggle_like(:unliked)
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :published_at, :visibility)
  end

  def set_blog_post
    @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path, alert: "You are not authorized to edit this post." unless @blog_post.user == current_user
  end

  def toggle_like(status)
    like = current_user.likes.find_or_initialize_by(likeable: @blog_post)
    like.status = status
    like.save
    redirect_to @blog_post
  end
end
