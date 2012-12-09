class EditMailer < ActionMailer::Base
  default from: "csahlmanj@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.edit_mailer.idiom_edit_mailer.subject
  #
  def idiom_edit_mailer(user_id, idiom_id, edit_id)
    @user = User.find(user_id)
    @idiom = Idiom.find(idiom_id)
    @edit = Edit.find(edit_id)
    sleep 10
    mail to: @user.email, subject: "A language you're following was updated."
  end
end
