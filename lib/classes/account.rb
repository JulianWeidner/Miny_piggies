require 'sqlite3'
require 'bcrypt'

class Account
  
  def initialize(email_parm, password_parm)
    @email = email_parm
    @password = password_parm
    @db = SQLite3::Database.open('./database/account.db')
  end
    
  #accessors
  def email; @email end
  def password; @password end 
  def account; @account end 
  
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
     VALUES(?,?,?,?,?);',[@email, @password, firs_parm, last_parm, 0])
  end 
  

  
  
  #def create_test_acc
    #pass_encryptor
    #@db.execute('INSERT INTO accounts(email, password, first_name, last_name, total_val)
     #VALUES(?,?,?,?,?);',['test@testmail.com', @password, 'test_name', 'tested_name', 0])
  #end 

  
  
 #account creation

#account login
  def login
    encrypted_pass = BCrypt::Password.new(sql_get_pass)
    if encrypted_pass == @password
      @account = sql_get_acc
      puts "Logged in!"
    else
      "Error loggin in"
      exit 
    end
  end 


#Account End
end
 