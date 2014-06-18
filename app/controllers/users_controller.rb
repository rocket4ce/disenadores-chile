class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, except: [:show, :follow]


  def follow
    @user = User.find(params[:id])
     # => This assumes you have a variable current_user who is authenticated
    if current_user.toggle_follow!(@user)
      redirect_to user_path, :notice => "Lo Sigues"
    else
      redirect_to user_path, :alert => "Ya no lo Sigues"
    end
  end

  def index
    @search = User.search(params[:q])
    @users = @search.result(distinct: true)
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    @seguidores = @user.followers(User)
    @siguiendo = @user.followees(User)
    @portafolios = @user.portafolios.all
    unless current_user.id == @user.id
      case current_user.pago && @user.pago
      when true
      when @user.pago? 
        unless current_user.admin?
          redirect_to root_path, :alert => "El usuario #{@user.name} no tiene permiso para que vean su portafolios"
        end
      end
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "No puedes actualizar el usuario, recuerde que debe introduccir fecha de pago, cuando este activado el checkbox"
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "Usuario eliminado."
    else
      redirect_to users_path, :notice => "No puedes eliminarte a ti mismo."
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role, :pago, :fechapago, :avatar)
  end

end
