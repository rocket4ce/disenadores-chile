class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, except: [:show]

  def index
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
    end
    authorize @users
  end

  def show
    @user = User.friendly.find(params[:id])
    unless current_user.id == @user.id
      case current_user.pago && @user.pago
      when true
      when @user.pago? 
        redirect_to root_path, :alert => "El usuario #{@user.name} no tiene permiso para que vean su portafolios"
      when current_user.pago?
        redirect_to root_path, :alert => "Para poder ver los portafolios de otros tienes que estar estar al día con tus cuotas"
      end
    end
  end

  def update
    @user = User.friendly.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.friendly.find(params[:id])
    authorize user
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role, :pago, :fechapago, :avatar)
  end

end
