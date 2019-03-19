require './lib/classes/account.rb'
#This is the main application. It is the View of the application, and gets the input
#

#INPUT METHODS
#they return input at various parts of the application
def create_test_acc
  user = Account.new('test@testmail.com','test123')
  user.sql_write
end
  
def get_login
  print "| Email: "
  email = gets.chomp.downcase
  print "| Password: "
  password = gets.chomp
  return email, password #Tupel example used here, assignment can be found at the top of the main application function
end

def get_create
  print "| Email: "
  email = gets.chomp.downcase
  print "| First Name: "
  first_name = gets.chomp.capitalize
  print "| Last Name: "
  last_name = gets.chomp.capitalize
  print "| Password: "
  pass = gets.chomp
  print "| Password Check: "
  pass_check = gets.chomp
  if pass != pass_check
    exit #while loop
  else
    new_user = Account.new(email, pass).create_acc(first_name,last_name)
  end
end

def univ_input
  print "| Input: "
  gets.chomp
end

#VIEW METHODS
#all these methods will handle view printing, some of them have input returns. I'll write a universal input method shortly
def startup_view
  view = <<-string
 ____________________________________________
|                                            |
|                                            |
|                                            |
|                Miny Piggies                |
|                                            |
|                                            |
|                                            |
|                                            |
|______________________ Center line          |
|        _____________________________       |
|       |            Login            |      |
|        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯       |
|        _____________________________       |
|       |        Create Account       |      |
|        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯       |
|        _____________________________       |
|       |            Help             |      |
|        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯       |
|                                            |
|____________________________________________|
string
  print view
  print "| INPUT(login,create,help): "
  input = gets.chomp.downcase
end

def account_view(user_obj_parm)
  user = user_obj_parm
  #prints data
  #write a loop for piglets 
  view = %(
 ____________________________________________
|                                            |
|  Account Value: $#{user.acc_val}                 
|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|
|#{user.piggies} 
|
|
|
|
|____________________________________________|
|_________
| ACTIONS |__________________________________|
|¯¯¯¯¯¯¯¯¯                                   |
|             | Piglet Actions |             |
|                                            |
| Create Piglet                              |
| Add Funds from the Sow                     |
| Transfer funds between Piglets             |
| Delete Piglet                              |
|                                            |
|             |  Sow Actions  |              |
|                                            |
| Add funds                                  |
| Withdraw Funds                             |
| Transfer To Piglet                         | 
| Setup Auto Feed                            | 
)
  print view
  print "| INPUT: "
  gets.chomp.downcase
end

#Main method. The whole application comes together within this method. Change if you dare. 
def application
  start_input = startup_view
  if start_input == 'login'
    #login
    email, pass = get_login #tupel
    
    user = Account.new(email, pass)
    user.login
    #show financial and actions
    account_input = account_view(user)
    case account_input
      when 'create'
        user.add_piglet(user.email)
      when 'add funds'
        puts "How much money are you adding?"
        user.add_funds(univ_input.to_i)
      when 'withdraw funds'
        puts "How much money are you withdrawing?"
        user.withdraw_funds(univ_input.to_i)
      when 'auto feed'
        puts "| This will be a percentage of each deposit made into the total account.\n| It will automatically allocate that money to the specified piglet (goal).\n"
        puts "What Goal would you like to setup?"
        goal = univ_input
        puts "What percentage?(for 5% type: 5)"
        percentage = univ_input.to_i
        print user.deposit_percentage(goal, percentage)
       
    end 
    
  elsif start_input == 'create'
  else
    puts "not coded"
    exit
  end
end

#Actually run application
application



