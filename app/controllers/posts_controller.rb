class PostsController < ApplicationController
  before_action :authenticate, only: :new

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @category = Category.find(params[:post][:category_id])
    
    @post = @category.posts.build(post_params)

    if @post.save
      flash[:primary] = 'Пост был создан.'
      redirect_to root_path
    else
      flash[:danger] = @post.errors.full_messages.join(' ')
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id, :creator)
  end

  def authenticate
    if current_user.nil?
      redirect_to root_path
      flash[:danger] = 'Войдите в свой аккаунт или зарегистрируйтесь!'
    end
  end
end
