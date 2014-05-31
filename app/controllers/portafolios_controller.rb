class PortafoliosController < ApplicationController
  before_action :set_portafolio, only: [:show, :edit, :update, :destroy]

  # GET /portafolios
  # GET /portafolios.json
  def index
    @portafolios = Portafolio.all
  end

  # GET /portafolios/1
  # GET /portafolios/1.json
  def show
    @portafolios = Portafolio.find(params[:id])
  end

  # GET /portafolios/new
  def new
    @portafolios = Portafolio.find_by(id: params[:id])
    if current_user == @portafolios
      @user = current_user
      @portafolio = current_user.portafolios.new
    else
      redirect_to root_path, alert: 'No tiene acceso a esta pagina.'
    end
  end

  # GET /portafolios/1/edit
  def edit
  end

  # POST /portafolios
  # POST /portafolios.json
  def create
    # render text: params and return
    @portafolio = current_user.portafolios.new(portafolio_params)

    respond_to do |format|
      if @portafolio.save
        format.html { redirect_to user_portafolio_path(current_user, @portafolio), notice: 'Portafolio was successfully created.' }
        format.json { render :show, status: :created, location: @portafolio }
      else
        format.html { redirect_to :back }
        format.json { render json: @portafolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portafolios/1
  # PATCH/PUT /portafolios/1.json
  def update
    respond_to do |format|
      if @portafolio.update(portafolio_params)
        format.html { redirect_to @portafolio, notice: 'Portafolio was successfully updated.' }
        format.json { render :show, status: :ok, location: @portafolio }
      else
        format.html { render :edit }
        format.json { render json: @portafolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portafolios/1
  # DELETE /portafolios/1.json
  def destroy
    @portafolio.destroy
    respond_to do |format|
      format.html { redirect_to portafolios_url, notice: 'Portafolio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portafolio
      @portafolio = current_user.portafolios.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portafolio_params
      params.require(:portafolio).permit(:titulo, :descripcion, :user_id)
    end
end
