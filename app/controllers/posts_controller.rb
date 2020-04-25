class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  def index
    @posts = Post.order('created_at')
  end

  def show
   @post = Post.find(params[:id])
   @comment = Comment.new
   @comment.post_id = @post.id
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      #flash[:success] = "Post '#{@post.title}' has been Created !!!"
      redirect_to @post
    else
      render new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
   @post = Post.find(params[:id])
     if @post.update(post_params)
       flash[:success] = "Post '#{@post.title}' has been Successfully Updated !!!"
       redirect_to post_path(@post)
     else
       flash[:danger] = "Post '#{@post.title}' Did not Update, Try Again !!!"
       render 'edit'
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

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
