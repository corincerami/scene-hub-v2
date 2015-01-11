require "rails_helper"

describe Show do
  describe "attributes" do
    it { should respond_to :details }
    it { should respond_to :venue_id }
    it { should respond_to :show_date }
  end

  describe "validations" do
    it { should validate_presence_of :venue_id }
    it { should validate_presence_of :show_date }
  end

  describe "associations" do
    it { should have_many :gigs }
    it { should have_many :bands }
    it { should have_many :comments }
    it { should have_many :rsvps }
    it { should belong_to :venue }
  end
end
