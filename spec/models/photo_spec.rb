require "rails_helper"

describe Photo do
  describe "attributes" do
    it { should respond_to :image_file_name }
    it { should respond_to :image_content_type }
    it { should respond_to :image_file_size }
    it { should respond_to :image_updated_at }
    it { should respond_to :band_id }
  end

  describe "associations" do
    it { should belong_to :band }
  end

  describe "validations" do
    it { should validate_presence_of :image_file_name }
    it { should validate_presence_of :image_content_type }
    it { should validate_presence_of :image_file_size }
    it { should validate_presence_of :image_updated_at }
    it { should validate_presence_of :band_id }
  end  
end
