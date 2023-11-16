class UsersController < ApplicationController
    before_action :set_user, only: [:posts]
    before_action :authenticate_user!, only: [:posts]

    def posts
        @posts = @user.blog_posts.order(published_at: :desc)
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
end