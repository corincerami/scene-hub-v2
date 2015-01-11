require "rails_helper"

describe Rsvp do
  describe "attributes" do
    it { should respond_to :show_id }
    it { should respond_to :user_id }
  end

  describe "validations" do
    it { should validate_presence_of :show }
    it { should validate_presence_of :user }
  end

  describe "associations" do
    it { should belong_to :show }
    it { should belong_to :user }
  end
end
