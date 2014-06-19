class MailComentario < ActionMailer::Base
  default from: "rocket4ce@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mail_comentario.mail_comentario.subject
  #
  def mail_comentario (comentario)
    @comentario = comentario
    @portafolio = @comentario.portafolio_id
    @mail = @comentario.user.email
    mail(to: @mail, subject: 'Tienes un Comentario #{@comentario.user.name}')
  end
end
