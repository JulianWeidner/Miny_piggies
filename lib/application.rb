require './lib/classes/account.rb'

logoff = false

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
  view = %(
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
  |        _____________________________       |                             |
  |       |            Login            |      |
  |        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯       |
  |        _____________________________       |                             |
  |       |        Create Account       |      |
  |        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯       |
  |        _____________________________       |                             |
  |       |            Help             |      |
  |        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯       |
  |                                            |
  |____________________________________________|                                      |
  | INPUT(login,create,help): 
)
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
  |¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|
  | 
  )
end

  def app()
    running = true 
    while running == true
      print start_input = startup_view
      if start_input == 'create'
        puts "call create command WIP"
        quit == tue
      else if start_input == 'login'
        email, password = get_login
        user = Account.new(email, password)
        print user.login
        #create acc view
        print account_view(user)
        quit == true
      else
        "puts error"
         quit = true
      end
    end
  end

#call app
app 

  
#application end  
end

