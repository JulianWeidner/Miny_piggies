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
  
  def auto_disperse(new_deposit_val)
    piggies = get_piggies(@email)
    remove_from_deposit = []
    total_removed = 0
    for piglet in piggies do 
      #gets the value of the deposit percentage * the new_deposit_val.
      val_to_piglet = new_deposit_val * (piglet[1]['deposit_percentage'].to_f / 100)
      # adds the new funds to the current val of the piglet 
      piglet[1]['current_val'] += val_to_piglet
      #Tracks values being removed from the deposit val
      remove_from_deposit.push(val_to_piglet)
    end
    
    remove_from_deposit.each do |elm|
      total_removed += elm
    end
    update_piggies(piggies, @email)
    unallocated_funds = new_deposit_val - total_removed #from deposit
  end
  
  #Withdraws funds from piglets to the main acc before a withdraw from the main acc
  def auto_withdraw
    #get the piglets
    #loop through piglet, get the percentage to withdraw from the acc
    #tbh, I don't think this should be a feature
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