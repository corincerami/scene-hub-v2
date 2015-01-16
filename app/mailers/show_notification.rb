class ShowNotification < ActionMailer::Base
  default from: "admin@scenehub.rocks"

  def notification(follow)
    @follow = follow

    mail to: follow.user.email,
      subject: "#{follow.band.name} announced a new show!"
  end
end
