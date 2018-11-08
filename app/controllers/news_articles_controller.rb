class NewsArticlesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  before_action :find_news_article, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def new
    @news_article = NewsArticle.new
  end

  def create
    @news_article = NewsArticle.new news_article_params
      
    if @news_article.save
      redirect_to news_articles_path(@news_article)
    else
      render :new
    end
  end

  def show
    
  end

  
  def destroy
    
    
    @news_article.destroy
    
    redirect_to news_articles_path
  end

  def index
    @news_articles = NewsArticle.all.order(created_at: :desc)
  end

  def edit
    

  end

  private
  
  def news_article_params
    params.require(:news_article).permit(:title, :description, :published_at, :view_count)
  end

  def find_news_article
    
    @news_article = NewsArticle.find params[:id]

  end

  def authorize_user!
    unless can? :crud, @news_article
      flash[:danger] = "Access Denied"
      redirect_to new_sessions_path
    end
  end

end
