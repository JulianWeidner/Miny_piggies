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
  logoff = true
end