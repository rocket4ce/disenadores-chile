class PerfilesController < ApplicationController
  before_action :set_perfil, only: [:show, :edit, :update, :destroy]

  def show
      @user = current_user
      @user.perfil ||= Perfil.new
      @perfil = @user.perfil
  end

  def create
    @perfil = current_user.perfiles.new(perfil_params)

    respond_to do |format|
      if @perfil.save
        format.html { redirect_to @perfil, notice: 'Perfil was successfully created.' }
        format.json { render action: 'show', status: :created, location: @perfil }
      else
        format.html { render action: 'new' }
        format.json { render json: @perfil.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = current_user
    @perfil = @user.perfil
    respond_to do |format|
      if @user.perfil.update(perfil_params)
        format.html { redirect_to @perfil, notice: 'Perfil was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
      end
    end
  end


  private
    def set_perfil
      # @perfil = Perfil.find(params[:id])
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perfil_params
      params.require(:perfil).permit(:user_id, :nombre, :apellidos, :ocupacion, :compania, :web, :face, :tw, :dribble, :linkedin, :vimeo, :flickr, :youtube, :pinterest, :tumblr, :google, :bio)
    end
end