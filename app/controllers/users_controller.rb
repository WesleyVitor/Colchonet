class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(valid_params)
    if @user.save
      SignupMailer.confirm_email(@user).deliver_now
      redirect_to root_path
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(valid_params)
      redirect_to @user, :notice => "Sucesso"
    else
      render :edit
    end
  end

  private
  def valid_params
    params.require(:user).permit(:full_name, :location, :password, :email, :bio)
  end
  
end