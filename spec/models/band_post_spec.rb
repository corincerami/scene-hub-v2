require "rails_helper"

describe BandPost do
  describe "attributes" do
    it { should respond_to :band_id }
    it { should respond_to :title }
    it { should respond_to :content }
    it { should respond_to :created_at }
    it { should respond_to :updated_at }
  end

  describe "validations" do
    it { should validate_presence_of :band_id }
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
  end

  describe "associations" do
    it { should belong_to :band}
  end
end
