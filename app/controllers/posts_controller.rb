class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :post_owner]
  before_action :require_login, except: [:index, :show]
  before_action :post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
    #@posts = Post.where(author_id: current_user)
  end

  def show
   @post = Post.find(params[:id])
   @comment = Comment.new
   @comment.post_id = @post.id
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      #flash[:success] = "Post '#{@post.title}' has been Created !!!"
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
#@posts = Post.where(author_id: current_user)
def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      redirect_to posts_path
    end
end

  def destroy
   @post = Post.find(params[:id])
     if @post.destroy
       flash[:success] = "Post '#{@post.title}' has been Successfully Deleted !!!"
       redirect_to posts_path
     else
       flash[:danger] = "Post '#{@post.title}' Did not Deleted.. !!!"
     end
   end

  private
  def find_post
      @post = Post.find(params[:id])
  end

  def post_owner
     unless @post.author_id == current_user.id
      flash[:error] = 'Access Denied!! You are not The Author of this Post'
      redirect_to posts_path
     end
  end


  def post_params
    params.require(:post).permit(:title, :body, :image, :author)
  end
end
