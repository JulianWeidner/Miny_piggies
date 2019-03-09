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
    account = @db.execute('SELECT * FROM accounts WHERE email = ?',[@email])
  end
  
  def sql_write(first_parm, last_parm) #private?
     @db.execute('INSERT INTO accounts(email, password, first_name, last_name, total_val)
     VALUES(?,?,?,?,?);',[@email, @password, firs_parm, last_parm, 0])
  end 
  
  def check_pass?
     account = sql_get_acc #returns an array of the sql value the second val being the acc pass
     account[0][1] == @password
  end
  

  
  
 #account creation

  
  def login
   recrypted_pass = BCrypt::Password.create(@password)
   account = @db.execute('SELECT EXISTS (SELECT * FROM accounts WHERE email = ? AND password = ?);',[@email, recrypted_pass])
   puts account[0][1]
   puts recrypted_pass
   puts  "Logged in"
  end 
end
 