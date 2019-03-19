require 'sqlite3'
require 'bcrypt'
require 'yaml'
require './lib/modules/piggies.rb'
require './lib/modules/funds.rb'

class Account
  
  include Piggies #modules
  include Funds
  def initialize(email_parm, password_parm)
    @email = email_parm
    @password = password_parm
    @db = SQLite3::Database.open('./database/account.db')
  end
  
  #accessors
  def email; @email end
  def password; @password end 
  def account; @account end 
  
  #account accessors
  def first_name; @account[0][1] end
  def last_name; @account[0][2] end
  def acc_val; @account[0][3] end
  def piggies; @account[0][4] end
    

  #called during creation only. Not for login.
  def match_pass?(check_pass_parm)
    @password == check_pass_parm
  end
  
  def pass_verified?
    encrypted_pass = BCrypt::Password.new(sql_get_pass)
    encrypted_pass == @password ? true : false  
  end
  #check existing account(email)
  #called before sql storage
  def pass_encryptor #private
    @password = BCrypt::Password.create(@password)
  end

  #Account SQL methods
  #These deal with any kind of name/email/password etc.
  #Most of them are private because they're only internally called by methods within this class :)
  #Piglet/Piggies Specific SQL updates are found in the piggies module
  #
  #Private Methods are defined at the bottom of the class, but here is a list.
  #
  #
  def sql_get_acc #private returns an array of the account and its values
    account = @db.execute('SELECT email, first_name, last_name, total_val, piggies FROM accounts WHERE email = ?',[@email])
  end

  def sql_get_pass #private
    password = @db.execute('SELECT password FROM accounts WHERE email = ?;',[@email])
    password[0][0].to_s
  end

  def sql_write(first_parm, last_parm)#private
    pass_encryptor
    piggies = {}
      @db.execute('INSERT INTO accounts(email, password, first_name, last_name, total_val, piggies)
  VALUES(?,?,?,?,?,?);',[@email, @password, first_parm, last_parm, 0, piggies.to_yaml])
  end 
  
#account creation
  def create_acc(first, last)
    sql_write(first,last)
  end

  
#account login
  def login
    if pass_verified?
      @account = sql_get_acc
      puts "\nWelcome Back, #{first_name}\n"
      true
    else
      print "|\n Error loggin in\n| Try Again"
      return false
    end
  end 

#Account End
end