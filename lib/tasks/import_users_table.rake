require 'csv'

namespace :import do
  desc "Import users from CSV"
  task users: :environment do
    file_path = Rails.root.join('lib', 'users_table.csv')

    CSV.foreach(file_path, headers: true) do |row|
      user_data = row.to_h.slice('name', 'email', 'created_at')
      User.create!(user_data)
    end

    puts "Users imported successfully!"
  end
end