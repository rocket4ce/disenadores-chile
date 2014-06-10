class PortafoliosController < ApplicationController
  before_action :set_portafolio, only: [:edit, :update]


  def index
    if current_user.pago
      @portafolios = Portafolio.all
    else
       redirect_to root_path, :alert => "Para poder ver los portafolios de otros tienes que estar estar al día con tus cuotas"
    end
  end


  def show
    @portafolio = Portafolio.find(params[:id])
    # @portafolios = Portafolio.find(params[:id])
    @user = @portafolio.user_id
    @imagenes = @portafolio.adjuntos.all
  end


  def new
    if current_user.pago
      @user = current_user
      @portafolio = current_user.portafolios.new
      @imagenes = @portafolio.adjuntos.build
    else
       redirect_to root_path, :alert => "Para poder crear portafolios tienes que pagar la colegiatura"
    end
  end


  def edit
    @user = current_user
    # @portafolio = @user.portafolios.find_by(id: params[:id])
    @imagenes = @portafolio.adjuntos.build
    @portafolios = Portafolio.find(params[:id])
    @imagen = @portafolios.adjuntos.all
  end


  def create
    if current_user.pago
      # render text: params and return
      @portafolio = current_user.portafolios.new(portafolio_params)

      respond_to do |format|
        if @portafolio.save
          params[:adjuntos]['imagen'].each do |a|
            @user = current_user
            @imagenes = @portafolio.adjuntos.create!(:imagen => a, :portafolio_id => @portafolio.id, :user_id => @user.id)
          end
          format.html { redirect_to user_portafolio_path(current_user, @portafolio), notice: 'Portafolio was successfully created.' }
          format.json { render :show, status: :created, location: @portafolio }
        else
          format.html { redirect_to :back }
          format.json { render json: @portafolio.errors, status: :unprocessable_entity }
        end
      end
    else
       redirect_to root_path, :alert => "Para poder crear portafolios tienes que pagar la colegiatura"
    end
  end

  def update
    respond_to do |format|
      if @portafolio.update(portafolio_params)
        params[:adjuntos]['imagen'].each do |a|
          @user = current_user
          @imagenes = @portafolio.adjuntos.create!(:imagen => a, :portafolio_id => @portafolio.id, :user_id => @user.id)
        end
        format.html { redirect_to user_portafolio_path(current_user, @portafolio), notice: 'Portafolio was successfully updated.' }
        format.json { render :show, status: :ok, location: @portafolio }
      else
        format.html { render :edit }
        format.json { render json: @portafolio.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @portafolio = Portafolio.find(params[:id])
    if current_user.id === @portafolio.user_id
      @portafolio = current_user.portafolios.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to user_path(current_user), notice: 'Portafolio was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to user_path(current_user), alert: 'No puedes eliminar otros protafolios'
    end
  end

  private

    def set_portafolio
        if current_user.id === Portafolio.find(params[:id]).user_id
          @portafolio = current_user.portafolios.find(params[:id])
        else
          redirect_to user_path(current_user), alert: 'No tienes permiso para editar'
        end
    end

    def portafolio_params
      params.require(:portafolio).permit(:titulo, :descripcion, :user_id, adjuntos_attributes: [:id, :portafolio_id, :user_id, :imagen, :position])
    end
end
