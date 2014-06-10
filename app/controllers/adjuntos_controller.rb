class AdjuntosController < ApplicationController
	before_action :load, only: [:index,:edit,:destroy,:show]


	def create
	    @uploads = Adjuntos.new(uploads_params)
	    @uploads.save
		# render text: params and return
		# @uploads = @portafolio.uploads.new(uploads_params)
		# @uploads.user_id = current_user.id
		# respond_to do |format|
		# 	if @uploads.save
		# 		format.html { redirect_to user_portafolio_path(@portafolio.user_id, @portafolio), notice: 'Portafolio was successfully created.' }
		# 	else
		# 		redirect_to user_portafolio_path(@portafolio.user_id, @portafolio), alert: 'No hemos podido añadir tu comentario'
		# 	end
		# end
	end
	
	def destroy
	
	  if @portafolio.adjuntos.find(params[:id]).destroy
	  	redirect_to :back
	  end
	#	redirect_to user_portafolio_path(@portafolio.user_id, @portafolio), notice: 'imagen eliminado'
	end

  private

  def load
  	@user = current_user
  	@portafolio = @user.portafolios.find(params[:portafolio_id])
  end

	def uploads_params
		params.require(:upload).permit(:portafolio_id, :imagen)
	end
end
