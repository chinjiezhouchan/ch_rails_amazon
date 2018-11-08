require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do

# For new, the major difference that authenticating users introduces is the new contexts you need to test for.
  def current_user
    @current_user ||= FactoryBot.create(:user)
  end

  def news_article_of_current_user
    @news_article ||= FactoryBot.create(:news_article, user: current_user)
  end

  let(:news_article) {FactoryBot.create(:news_article, user: current_user)}

  describe "#new" do
    context "when no user is signed in" do
      it "redirects to the sign in page" do

        get(:new)

        expect(response).to redirect_to(new_sessions_path)
      end


      # it "flashes a danger" do
      #   get(:new)

      #   flash[:danger]
      # end

    end

    context "when user is signed in" do

      before do

        session[:user_id] = FactoryBot.create(:user).id
      end

      it "sets the instance variable to a new database row" do
        get(:new)
        expect(assigns(:news_article)).to be_a_new(NewsArticle)
      end


      it "renders the new template" do
        #Given and When 
        get(:new)

        # Then
        expect(response).to render_template(:new)

      end
    end
  end

  describe "#create" do
    def valid_request
      post(:create, params: { news_article: FactoryBot.attributes_for(:news_article)})
    end

    context "with no signed in user" do
      it "redirects to the new sessions page" do
        valid_request

        expect(response).to redirect_to(new_sessions_path)
      end

    end

    context "with signed in user" do

      before do

        # Remember this for the future as you did this wrong.

        session[:user_id] = current_user.id
      end

      context "valid request" do

        it "associates the job post with the current user" do
          # Given.
            # The user from the before do block, and the valid_request together give you what you need.
          valid_request
          # Expect that the last created news article.
          # You can call the user method from belongs_to to access the user_id. You don't need to use the user_id column directly.
          expect(NewsArticle.last.user).to eq(current_user)
        end

        it "creates a new news article in the db" do
          count_before = NewsArticle.count
          valid_request
          count_after = NewsArticle.count

          expect(count_after).to eq(count_before + 1)
        end

        it "redirects to the show page of the job post" do
          valid_request

          news_article = NewsArticle.last
          expect(response).to(redirect_to(news_articles_path(news_article)))
        end

        it "sets a success flash"

      end

      context "invalid request" do
        def invalid_request
          post(:create, params: { news_article: FactoryBot.attributes_for(:news_article, title: nil) })
        end

        it "doesn't create a news article in the db" do
          before_count = NewsArticle.count
          invalid_request
          after_count = NewsArticle.count

          expect(after_count).to eq(before_count)
        end

        it "renders the new template" do 
          invalid_request

          expect(response).to render_template(:new)
        end

        it "assigns the invalid job post to an instance var" do
          invalid_request

          # Then:
            # Check that an instance variable was made from the NewsArticle Model class
          expect(assigns(:news_article)).to(be_a(NewsArticle))

            # Check that the value of the news article is invalid.
            expect(assigns(:news_article)).to be_invalid
        end
      end
    end
  end
  
  describe "#show" do
    it "renders the show template" do
      news_article = FactoryBot.create(:news_article)
      get(:show, params: { id: news_article.id })

      expect(response).to render_template(:show)
    end


    it "sets @news_article to the right job post" do
      # Given: A news_article in the directory we set ourselves.

      news_article = FactoryBot.create(:news_article)

      # When: GET request for the show action with params id equal to the one in the database.
      get(:show, params: { id: news_article.id })

      # Then: We expect the value in the instance variable to equal the model instance database row we created.

      expect(assigns(:news_article)).to eq(news_article)

    end

  end

  describe "#destroy" do
    def del_an_article_req
      @news_article = FactoryBot.create(:news_article)

      delete(:destroy, params: { id: @news_article.id })
    end

    it "deletes object from db" do
    

      @news_article = FactoryBot.create(:news_article)

      delete(:destroy, params: { id: @news_article.id })

      find_attempt = NewsArticle.find(@news_article.id)
      
      expect(find_attempt).not_to eq(news_article)
    end

    it "assigns the right article to the instance variable" do
      del_an_article_req

      expect(assigns(:news_article)).to eq(@news_article)
    end

    it "removes the article from the database" do
      del_an_article_req

      expect(NewsArticle.find_by_id(@news_article.id)).to be_nil
    end

    it "redirects to the index page" do
      del_an_article_req

      expect(response).to redirect_to(news_articles_path)
    end


  end

  describe "#index" do
    it "assigns all database entries to the instance varaible @news_articles" do
      
        3.times do 
          FactoryBot.create(:news_article)
        end
      

      news_articles_ordered = NewsArticle.all.order(created_at: :desc)
      p news_articles_ordered

      get(:index)

      expect(assigns(:news_articles)).to eq(news_articles_ordered)

      # expect(assigns(:news_articles)).to eq([news_article_1, news_article_2])

    end

    it "renders the index page" do


    end
  end

  describe "#edit" do

    def pre_existing_article
      @news_article = FactoryBot.create(:news_article)
    end

    def valid_request
        get(:edit, params: { id: @news_article.id })
    end
    context "with no user signed in" do
      it "redirects to the sign in page" do
        
        news_article = FactoryBot.create(:news_article)
        get(:edit, params: { id: news_article.id })

        expect(response).to redirect_to(new_sessions_path)
      end
    end

    context "with user signed in" do
      before do
        session[:user_id] = current_user.id
      end

      context "but user is not owner" do
        # The before_action authorize_user! in the controller should handle checking authorization. No need to set up something here.
        it "redirects the user to the root_page" do
          # If I do another FactoryBot.create, then this should create yet another user for this news article, so that this news article will not belong to the user of the before block in this section.
          news_article = FactoryBot.create(:news_article)
          get(:edit, params: { id: news_article.id })

          expect(response).to redirect_to(new_sessions_path)

        end

        it "alerts the user with a flash" do
          news_article = FactoryBot.create(:news_article)
          get(:edit, params: { id: news_article.id })

          expect(flash[:danger]).to be
        end

      end

      context "and user owns news article" do

        def valid_request
          get(:edit, params: { id: news_article_of_current_user.id })
        end

        it "sets the instance variable to the right value" do
          
          # pre_existing_article
            # Error was: expected value = an article, but actual was nil. I think Actual was nil because authorization did not go through.
            # When I called the pre_existing_article method, it created a new user.
            # So later when I set up correct_article to search by id: @news_article.id, it brings up the article from pre_existing_article.
            # However, the user from the before block is wrong.
            # So, during the valid_request method, which also is set to edit the article with id: @news_article.id, the old user from the before block is not authorized to edit this new article. 
            # That's why you got exp
          
          # get(:edit, params: { id: news_article.id })
          get :edit, params: {id: news_article.id}

          expect(assigns(:news_article)).to eq(news_article)

        end

        it "renders the edit template" do
          pre_existing_article
          valid_request

          expect(response).to render_template(:edit)
        end

      end
    end

    
  end

  describe "#update" do


  end



end
