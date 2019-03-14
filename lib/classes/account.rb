require 'sqlite3'
require 'bcrypt'
require 'yaml'
require './lib/modules/piggies.rb'

class Account
  include Piggies
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
  
  def check_email
  end
  

  #called before sql storage
  def pass_encryptor #private
    @password = BCrypt::Password.create(@password)
  end

  #Sql methods 
  def sql_get_acc #private
    account = @db.execute('SELECT email, first_name, last_name, total_val, piggies FROM accounts WHERE email = ?',[@email])
  end

  def sql_get_pass
    password = @db.execute('SELECT password FROM accounts WHERE email = ?;',[@email])
    password[0][0].to_s
  end

  
  def sql_write(first_parm, last_parm) #private?
     @db.execute('INSERT INTO accounts(email, password, first_name, last_name, total_val)
     VALUES(?,?,?,?,?);',[@email, @password, firs_parm, last_parm, Hash['Piggies']])
  end 
  
  
  
  #def create_test_acc
    #pass_encryptor
    #@db.execute('INSERT INTO accounts(email, password, first_name, last_name, total_val)
     #VALUES(?,?,?,?,?);',['test@testmail.com', @password, 'test_name', 'tested_name', 0])
  #end 

  
  
#account creation
  def create_acc(first, last)
    sql_write(first,last)
  end

#account login
  def login
    encrypted_pass = BCrypt::Password.new(sql_get_pass)
    if encrypted_pass == @password
      @account = sql_get_acc
      
      puts "\nWelcome Back, #{first_name}\n"
      true
    else
      "Error loggin in"
      return false
      exit 
    end
  end 
  
  
  #Good luck. ITs about to be unreadable below this point
  #reate

  
 


#Account End
end
 