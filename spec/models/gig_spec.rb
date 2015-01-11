require "rails_helper"

describe Gig do
  describe "attributes" do
    it { should respond_to :band_id }
    it { should respond_to :show_id }
  end

  describe "validations" do
    it { should validate_presence_of :show_id }
    it { should validate_presence_of :band_id }
  end

  describe "associations" do
    it { should belong_to :show }
    it { should belong_to :band }
  end
end
