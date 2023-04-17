class UsersController < ApplicationController


  
    def new
      @user = User.new
      # For future re-render and autofill purposes
  
      render :new
    end
  
    def create
      # debugger
      @user = User.new(user_params)
  
      if @user.save
        login!(@user)
        redirect_to cats_url
      else
        render json: @user.errors.full_messages, status: 422
      end
    end
  

  
    def user_params
      params.require(:user).permit(:username, :password)
    end
  
  
  end