class BlogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @blogs = Blog.where(user_id: current_user.id)
  end

  def new
    @blog = Blog.new
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user
    if @blog.save
      flash[:success] = "Post created successfully"
      redirect_to root_path
    else
      flash[:error] = @blog.errors.full_messages
      render 'new'
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = current_user.blogs.find(params[:id])
    if @blog.update(blog_params)
      flash[:success] = "Post updated successfully"
      redirect_to root_path
    else
      flash[:error] = @blog.errors.full_messages
      render 'new'
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    if @blog.destroy
      flash[:success] = "Post deleted successfully"
    else
      flash[:error] = @blog.errors.full_messages
    end
    redirect_to root_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body)
  end
end
