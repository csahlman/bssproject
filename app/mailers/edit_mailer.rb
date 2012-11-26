class EditMailer < ActionMailer::Base
  default from: "csahlmanj@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.edit_mailer.idiom_edit_mailer.subject
  #
  def idiom_edit_mailer(user, idiom, edit)
    @user = user
    @idiom = idiom
    @edit = edit

    mail to: user.email, subject: "A language you're following was updated."
  end
end
