# Preview all emails at http://localhost:3000/rails/mailers/mail_comentario
class MailComentarioPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mail_comentario/mail_comentario
  def mail_comentario
    MailComentario.mail_comentario
  end

end
