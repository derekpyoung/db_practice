require 'rails_helper'

RSpec.describe DatabaseConnector do
  describe "querying the users table" do
    it "can return all users" do
      users = DatabaseConnector.query("SELECT * FROM users")
      expect(users).to be_an_instance_of(Array)
      expect(users.length).to eq(10)
      expect(users.first).to be_an_instance_of(Hash)
      first_user = users.first
      expect(first_user.keys).to match_array(["id", "name", "email", "created_at"])
      expect(first_user["id"]).to eq(1)
      expect(first_user["name"]).to eq("John")
      expect(Date.parse(first_user["created_at"])).to eq(Date.parse("2024-01-01"))
      user_ids = users.map { |user| user["id"] }
      expect(user_ids).to match_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    end

    it "can return a single user by id" do
      users = DatabaseConnector.query("SELECT * FROM users WHERE id = 2")
      expect(users).to be_an_instance_of(Array)
      expect(users.length).to eq(1)

      user = users.first
      expect(user).to be_an_instance_of(Hash)
      expect(user.keys).to match_array(["id", "name", "email", "created_at"])
      expect(user["id"]).to eq(2)
      expect(user["name"]).to eq("Sarah")
      expect(user["email"]).to eq("sarah@hotmail.com")
      expect(Date.parse(user["created_at"])).to eq(Date.parse("2024-01-02"))
    end

    it "can return a single user by email" do
      users = DatabaseConnector.query("SELECT * FROM users WHERE email = 'fabio@gmail.com'")
      expect(users.length).to eq(1)
      user = users.first
      expect(user["id"]).to eq(5)
      expect(user["name"]).to eq("Fabio")
      expect(user["email"]).to eq("fabio@gmail.com")
      expect(Date.parse(user["created_at"])).to eq(Date.parse("2024-02-05"))
    end

    it "can return a users by email domain" do
      users = DatabaseConnector.query("SELECT * FROM users WHERE email domain = 'hotmail.com'")
      expect(users.length).to eq(3)
      user = users.first
      expect(user["id"]).to eq(1)
      expect(user["name"]).to eq("John")
      expect(user["email"]).to eq("john@hotmail.com")
      expect(Date.parse(user["created_at"])).to eq(Date.parse("2024-01-01"))
    end
  end
end