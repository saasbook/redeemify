class SessionsController < ApplicationController
  def new
    # @user = User.new
    if current_user == nil
      @user = User.new
    else
      if current_user.code == ""
        @user = User.new
      else
        redirect_to '/sessions/offer', notice: "Already register call from sessions#new"
      end
    end
  end

  def index
    if current_user.nil?
      @current_user = User.find(session[:user_id])
    else
      if current_user.code == ""
        redirect_to root_url, notice: "Please Enter your code!"
      else
        redirect_to '/sessions/offer', notice: "Already register call from sessions#index"
      end
    end
  end

  def create  ## Need to implement whether it's vendor or user
    user = User.from_omniauth(env["omniauth.auth"])
    if user.code.nil? || user.code == ""
      session[:user_id] = user.id
      # redirect_to root_url, notice: "Signed in!"
      redirect_to '/sessions/new', notice: "Signed in!"
      # redend "new"
    else
      session[:user_id]= user.id
      redirect_to '/sessions/offer', notice: "Offer page"
    end
  end

  def vendor
    # redend "new"
  end

  def offer
    current_user = User.find(session[:user_id])
    if current_user.code.nil? || current_user.code == ""
      @current_code = params[:code]
      current_user.code = @current_code
      current_user.save!
    else
      @current_code = current_user.code
    end

  end

  def show
    @user = User.find(session[:user_id])
    
  end

  def update
    # @user = Movie.find(params[:user_id])


    # if @user.update_attributes(params[:user_id])
    #     redirect_to "/sessions/show"
    # else
    #     render "edit"
    # end
  end


  def edit

  end



  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end


end
