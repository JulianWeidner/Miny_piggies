require './lib/classes/account.rb'



def get_login
  print "| Email: "
  email = gets.chomp.downcase
  print "| Password: "
  password = gets.chomp
  return email, password
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
    exit
  else
    new_user = Account.new(email, pass).create(first_name,last_name)
  end
end

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
    #puts data
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

 
def application
  start_input = startup_view
  if start_input == 'login'
    #login
    email, pass = get_login
    user = Account.new(email, pass)
    user.login
    #show financial and actions
    account_view(user)
    
  elsif start_input == 'create'
    get_create
  else
    puts "not coded"
    exit
  end
  
end
#call app
#Sapp 

application



