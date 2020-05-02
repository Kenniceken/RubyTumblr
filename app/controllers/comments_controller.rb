class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy, :comment_owner]
  before_action :require_login, except: [:create]
  before_action :comment_owner, only: [:destroy, :comment_owner]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.author_id = current_user.id #or whatever is you session name
    if @comment.save
      redirect_to @post
    else
      flash.now[:error] = "error"
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
  	@comment = @post.comments.find(params[:id])
  	@comment.destroy
  	redirect_to post_path(@post)
  end

  private

  def find_comment
      @comment = Comment.find(params[:id])
  end

  def comment_owner
     unless @comment.author_id == current_user.id
      flash[:error] = 'Access Denied!! This Comment Does Not Belong to You!!!'
        redirect_to post_path(@comment.post)
     end
  end

  def comment_params
    params.require(:comment).permit(:body, :author_id, :post_id)
  end
end
