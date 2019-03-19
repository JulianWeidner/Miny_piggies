require 'yaml'
require 'sqlite3'

module Funds

  #SQL METHODS
  def update_funds(new_val)
    @db.execute("UPDATE accounts SET total_val = ? WHERE email = ?", [new_val, @email])
  end
  
  #funds manipulations
  def add_funds(input_val)
    new_val = input_val + acc_val
    update_funds(new_val)
  end
  
  def withdraw_funds(input_val)
    new_val = acc_val - input_val
      if new_val >= 0 
        update_funds(new_val)
      else
        puts "Insufficent Funds"
      end
  end

end