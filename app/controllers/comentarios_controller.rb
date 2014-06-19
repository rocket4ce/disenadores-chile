class ComentariosController < ApplicationController
	before_action :cargar_portafolio
	
	def create
		# render text: params and return
		@comentarios = @portafolio.comentarios.new(comentarios_params)
		@comentarios.user_id = current_user.id
		respond_to do |format|
			if @comentarios.save
				MailComentario.mail_comentario(@comentarios).deliver
				format.html { redirect_to user_portafolio_path(@portafolio.user, @portafolio), notice: 'El comentario a sido creado' }
			else
				redirect_to user_portafolio_path(@portafolio.user_id, @portafolio), alert: 'No hemos podido añadir tu comentario'
			end
		end
	end
	
	def destroy
		@comentarios = @portafolio.comentarios.find(params[:id])
		@comentarios.destroy

		redirect_to user_portafolio_path(@portafolio.user_id, @portafolio), notice: 'Comentario eliminado'
	end
	
	private
	
	def cargar_portafolio
		@portafolio = Portafolio.find(params[:portafolio_id])
		@user = current_user
	end
	
	def comentarios_params
		params.require(:comentario).permit(:portafolio_id, :comentario, :user_id)
	end
end
