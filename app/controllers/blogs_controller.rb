class BlogsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_action :set_blog, only: [ :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    if current_user.admin?
      @blog = current_user.blogs.new
    else
      redirect_to root_url, notice: 'No tienes permiso para eso'
    end
  end

  def edit
    if current_user.admin?
     @blog = current_user.blogs.find(params[:id])
   else
      redirect_to root_url, notice: 'No tienes permiso para eso'
    end
  end

  def create
    @blog = current_user.blogs.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user.admin?
      @blog.destroy
      respond_to do |format|
        format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_url, notice: 'No tienes permiso para eso'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = current_user.blogs.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:titulo, :cuerpo, :user_id, :bootsy_image_gallery_id)
    end
end
