class Api::V1::SessionsController < Api::ApplicationController

  def create
    user = User.find_by_email params[:email]

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { status: :success }
      # head :ok
    else
      head :not_found
      # render json: { status: error, message: "Wrong credentials"}
    end
  end

  def destroy

  end

end
