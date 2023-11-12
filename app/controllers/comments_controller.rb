class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog_post
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @blog_post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to blog_post_path(@blog_post, anchor: "comments"), notice: "Comment was successfully created."
    else
      redirect_to blog_post_path(@blog_post, anchor: "comments"), alert: "Error creating comment."
    end
  end

  def destroy
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = @blog_post.comments.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
      redirect_to @blog_post, notice: "Comment was successfully deleted."
    else
      redirect_to @blog_post, alert: "You are not authorized to delete this comment."
    end
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end