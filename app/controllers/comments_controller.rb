class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog_post
  before_action :set_comment, only: [:destroy, :edit, :update]
  before_action :authorize_user!, only: [:destroy, :edit, :update]

  def create
    @comment = @blog_post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to blog_post_path(@blog_post, anchor: "comments"), notice: "Comment was successfully created."
    else
      redirect_to blog_post_path(@blog_post, anchor: "comments"), alert: "Error creating comment."
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to blog_post_path(@blog_post, anchor: "comments"), notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @blog_post, notice: "Comment was successfully deleted."
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def authorize_user!
    redirect_to @blog_post, alert: "You are not authorized to delete this comment." unless @comment.user == current_user
  end
end