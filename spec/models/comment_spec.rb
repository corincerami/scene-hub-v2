require "rails_helper"

describe Comment do
  describe "attributes" do
    it { should respond_to :user }
    it { should respond_to :title }
    it { should respond_to :body }
    it { should respond_to :show }
    it { should respond_to :created_at }
    it { should respond_to :updated_at }
  end

  describe "validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :body }
    it { should validate_presence_of :show_id }
  end

  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :show }
  end
end
