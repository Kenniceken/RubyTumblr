module PostsHelper
  def post_params
     params.require(:post).permit(:title, :body, :tag_list, :tag, { tag_ids: [] }, :tag_ids, :image, :author)
  end
end
