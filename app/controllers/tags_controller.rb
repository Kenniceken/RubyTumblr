class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name)
  end


end
