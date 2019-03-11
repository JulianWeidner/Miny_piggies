require './lib/classes/account.rb'

logoff = false

def get_login
  print "| Email: "
  email = gets.chomp.downcase
  print "| Password: "
  password = gets.chomp
  return email, password
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


while logoff == false
  email, password = get_login
  user = Account.new(email, password)
  print user.login
  #create acc view
  print account_view(user)
  
  logoff = true
end

