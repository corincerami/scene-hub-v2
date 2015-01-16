class ShowNotification < ActionMailer::Base
  default from: "admin@scenehub.rocks"

  def notification(follow, show)
    @follow = follow
    @show = show

    mail to: follow.user.email,
      subject: "#{follow.band.name} announced a new show!"
  end
end
