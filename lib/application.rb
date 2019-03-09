require './lib/classes/account.rb'

logoff = false

def get_login
  print "| Email: "
  email = gets.chomp.downcase
  print "| Password: "
  password = gets.chomp
  return email, password
end


while logoff == false
  email, password = get_login
  user = Account.new(email, password)
  print user.login
  #user_data is a 2d array of the entire sql acc
  #array = [0][email, firstname, lastname, acc val, piggies]
  user_data = user.account 
  print user_data
  logoff = true
end

