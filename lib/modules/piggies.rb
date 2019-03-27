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
  
  
  
  def set_deposit_percentage(goal, percentage)
    piggies = get_piggies(@email)
    piggies["#{goal}"] ['deposit_percentage'] = percentage
    update_piggies(piggies, @email)
  end
  
  def set_withdraw_percentage(goal, percentage)
    piggies = get_piggies(@email)
    piggies["#{goal}"]['withdraw_percentage'] = percentage
    update_piggies(piggies, @email)
  end
  
  def set_lock(goal, lock_status)
    piggies = get_piggies(@email)
    #thisneeds to be re-writen to check the curren value and just swap from 0 to 1, which also means DB needs changed :)
    if lock_status == 'true'
      piggies["#{goal}"]['locked'] = 'true'
    elsif lock_status == 'false'
      piggies["#{goal}"]['locked'] = 'false'
    end
    update_piggies(piggies, @email)
  end
  
  #returns the value of all the piggies withdraw percentage
  def piggies_withdraw_percentage
    piggies = get_piggies(@email)
    total_percentage = 0
    for piglet in piggies do 
      #piglet[1] = hash
      total_percentage += piglet[1]['withdraw_percentage'] 
    end
    total_percentage
  end
  
  def auto_deposit
    total_val = acc_val
    deposit_amt_arr = Array.new
    #get deposit amounts for each piggy store in an array
    piggies = get_piggies(@email)
   
    for piglet in piggies do
      deposit_amt_arr.push(piglet[1]['deposit_percentage'])
    end
    #take each elm of deposit_percentages and multiply them by the total acc_val. store inside val_to_feed
    for piglet in piggies do 
      deposit_val = (piglet[1]['deposit_percentage'].to_f / 100 ) * total_val
      puts piglet[1]['current_val'] += deposit_val
      deposit_amt_arr.push(deposit_val)
    end
    update_piggies(piggies, @email)
    deposit_amt_arr
  end
  
  
  def auto_withdraw
    withdraw_amt_arr = Array.new
   
    piggies = get_piggies(@email)
    for piglet in piggies do
      if piglet[1]['locked'] == false
        withdraw_amt = (piglet[1]['withdraw_percentage'].to_f / 100) * (piglet[1]['current_val'])
        piglet[1]['current_val'] -= withdraw_amt
        withdraw_amt_arr.push(withdraw_amt)
      end
    end
   update_piggies(piggies, @email) 
   withdraw_amt_arr
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
  
  
 

  
    private :update_piggies, :get_piggies
end