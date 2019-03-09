require 'sqlite3'

db = SQLite3::Database.new('./database/account.db')

rows = db.execute <<-SQL
  CREATE TABLE accounts(
    email varchar(100),
    password varchar(200),
    first_name varchar(50),
    last_name varchar(50),
    total_val int,
    piggies blob
);
SQL



rows

