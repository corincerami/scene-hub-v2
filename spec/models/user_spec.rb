require "rails_helper"

describe User do
  describe "attributes" do
    it { should respond_to :email }
    it { should respond_to :encrypted_password }
    it { should respond_to :reset_password_token }
    it { should respond_to :reset_password_sent_at }
    it { should respond_to :remember_created_at }
    it { should respond_to :sign_in_count }
    it { should respond_to :current_sign_in_at }
    it { should respond_to :last_sign_in_at }
    it { should respond_to :current_sign_in_ip }
    it { should respond_to :last_sign_in_ip }
    it { should respond_to :failed_attempts }
    it { should respond_to :unlock_token }
    it { should respond_to :locked_at }
    it { should respond_to :created_at }
    it { should respond_to :updated_at }
  end

  describe "associations" do
    it { should have_many :bands }
    it { should have_many :comments }
    it { should have_many :rsvps }
    it { should have_many :follows }
  end

  describe "deleting a user" do
    it "should destroy its dependencies" do
      show = create(:show)
      user = show.band.user
      create(:rsvp, user: user)
      create(:follow, user: user)
      band_count = Band.count
      comment_count = Comment.count
      rsvp_count = Rsvp.count
      show_count = Show.count
      follow_count = Follow.count

      user.destroy

      expect(Band.count).to eq band_count - 1
      expect(Comment.count).to eq comment_count - 1
      expect(Rsvp.count).to eq rsvp_count - 1
      expect(Show.count).to eq show_count - 1
      expect(Follow.count).to eq follow_count - 1
    end
  end
end
