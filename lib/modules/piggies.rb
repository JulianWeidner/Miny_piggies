#This module is used for changing values within the SQL blob
require 'yaml'
require 'sqlite3'

module Piggies
# All Piglet Manipulations will use a method from this class.
# This includes SQL modifications to @account
#SQL modifications are private, defined at the bottom of the module
#Private methods:
=begin
- update_piggies called inside add_piglet 
- get_piggies called inside add_piglet
=end
 
  #writes the new hash  
  def update_piggies(ruby_hash, email)
    piggies = ruby_hash.to_yaml
    @db.execute("UPDATE accounts SET piggies = ? WHERE email = ?",[piggies, email])
  end

  #gets the value of the hash from SQL
  def get_piggies(account)
    piggies_sql = @db.execute('SELECT piggies FROM accounts where email = ? ',[account])
    if piggies_sql != nil   
      return YAML.load(piggies_sql[0][0])
    end
  end 
  
  def transfer_to_piggies(goal, transfer_amount)
    total_val = acc_val
    piggies = get_piggies(@email)
    piggies["#{goal}"]['current_val'] += transfer_amount
    update_piggies(piggies, @email)
  end
  
  
  
  def deposit_percentage(goal, percentage)
    piggies = get_piggies(@email)
    piggies["#{goal}"] ['deposit_percentage'] = percentage
    piggies["#{goal}"]
    update_piggies(piggies, @email)
  end


  def add_piglet(email)
    #get the hash from the account
    piggies = get_piggies(email)
    #gets piglet info
    print "| Goal Name: "
    goal_name = gets.chomp.downcase
    print "| Goal target: "
    target_val = gets.chomp.to_i

    #initalize a piglet with the follow values
    piglet = {goal_name => {
    'current_val' => 0, 
    'target_val' => target_val,
    'withdraw_percentage' => 0,
    'deposit_percentage' => 0,
    'locked'  => false}}

    #if it is a new account and has 0 piglets merge wont work on a nil hash, so I set it equal to the new hash. 
    if piggies.any?
     update_piggies(piggies.merge(piglet), email)
    else 
      update_piggies(piggies['piggies'] = piglet, email)
    end
  end
  
  
  
  def set_deposit_percentage
    
  end
  

  
    private :update_piggies, :get_piggies
end