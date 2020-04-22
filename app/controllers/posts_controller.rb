class PostsController < ApplicationController
  def index
    @posts = Post.order('created_at')
  end

  def show
   @post = Post.find(params[:id])
   # @comment = Comment.new
   # @comment.post_id = @post.id
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post '#{@post.title}' has been Created !!!"
      redirect_to @post
    else
      render new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
