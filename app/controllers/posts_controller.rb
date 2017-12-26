class PostsController < ApplicationController
  before_action :set_user, only: %i{index new create show edit update destroy}
  before_action :set_post, only: %i{show edit update destroy}

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = @user.posts.new
  end

  def edit
  end

  def create
    success = -> { redirect_to(posts_path, notice: 'Post was successfully created.') }
    failure = -> (post) { @post = post; render(:new) }
    PostService::Create.call(@user, post_params, success: success, failure: failure)
  end

  def update
    success = -> { redirect_to(posts_path, notice: 'Post was successfully updated.') }
    failure = -> (post) { @post = post; render(:edit) }
    PostService::Update.call(@post, post_params, success: success, failure: failure)
  end

  def destroy
    success = -> { redirect_to(posts_path, notice: 'Post was successfully destroyed') }
    PostService::Delete::call(@post, success: success)
  end

  private
    def set_user
      @user = current_user
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :photo)
    end
end
