class Notification < ApplicationMailer

  def sharing_notice(from_user, to_user)
    @from_user = from_user
    @to_user = to_user
    mail(to: @to_user.email, subject: "ファイルが共有されました")
  end
end
