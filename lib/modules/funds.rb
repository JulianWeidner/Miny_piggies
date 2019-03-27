require 'yaml'
require 'sqlite3'

module Funds

  #SQL METHODS
  def update_funds(new_val)
    @db.execute("UPDATE accounts SET total_val = ? WHERE email = ?", [new_val, @email])
  end
  
  #funds manipulations
  def add_funds(input_val)
    total_val = acc_val
    update_funds(total_val += input_val)
  end
  
  def withdraw_funds(input_val)
    total_val = acc_val
    
    puts update_funds(total_val -= input_val)  
  end

end