require 'test_helper'

class MailComentarioTest < ActionMailer::TestCase
  test "mail_comentario" do
    mail = MailComentario.mail_comentario
    assert_equal "Mail comentario", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
