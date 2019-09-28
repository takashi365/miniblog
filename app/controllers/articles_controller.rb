class ArticlesController < ApplicationController
  before_action :move_to_index, except: :index
  def index
    @articles = Article.includes(:user).order("created_at DESC").page(params[:page]).per(3)
  end

  def new
  end

  def create
    Article.create(title: article_params[:title], article: article_params[:article], user_id: current_user.id)
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy if article.user_id == current_user.id
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])
    if article.user_id == current_user.id
      article.update(article_params)
    end
  end

  private
  def article_params
    params.permit(:title, :article)
  end
  
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
