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
  end
end
