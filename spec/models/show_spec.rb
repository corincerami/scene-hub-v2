require "rails_helper"

describe Show do
  describe "attributes" do
    it { should respond_to :details }
    it { should respond_to :venue_id }
    it { should respond_to :band_id }
    it { should respond_to :show_date }
  end

  describe "validations" do
    it { should validate_presence_of :venue_id }
    it { should validate_presence_of :band_id }
    it { should validate_presence_of :show_date }
  end

  describe "associations" do
    it { should have_many :comments }
    it { should have_many :rsvps }
    it { should belong_to :band }
    it { should belong_to :venue }
  end

  describe "deleting a show" do
    it "should destroy its dependencies" do
      show = create(:show)
      create(:rsvp, show: show)
      comment_count = Comment.count
      rsvp_count = Rsvp.count

      show.destroy

      expect(Comment.count).to eq(comment_count - 1)
      expect(Rsvp.count).to eq(rsvp_count - 1)
    end
  end
end
