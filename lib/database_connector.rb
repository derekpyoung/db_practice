require 'csv'

class DatabaseConnector
  CSV_PATH = Rails.root.join('lib', 'users_table.csv')

  def self.query(sql_query_string)
    case sql_query_string.downcase
    when /^select \* from users$/
      read_users_from_csv
    when /^select \* from users where id = (\d+)$/
      id = $1.to_i
      read_users_from_csv.select { |user| user["id"] == id }
    when /^select \* from users where email = '(.+)'$/
      email = $1
      read_users_from_csv.select { |user| user["email"] == email }
    else
      raise "Unsupported SQL query: #{sql_query_string}"
    end
  end

  def self.read_users_from_csv
    csv_data = CSV.read(CSV_PATH, headers: true)
    csv_data.map do |row|
      {
        "id" => row["id"].to_i,
        "name" => row["name"],
        "email" => row["email"],
        "created_at" => row["created_at"].to_s
      }
    end
  end
end

