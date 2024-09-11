class PostsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.new
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      respond_to do  |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("posts", partial: "posts/post", locals: {post: @post})
        end
        format.html {redirect_to @post, notice: "Successfully created post"}
      end 
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, notice: "Successfully updated post"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove(@post)
        end
        format.html {redirect_to posts_path, notice: "Successfully deleted post"}
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:body)
  end
end
