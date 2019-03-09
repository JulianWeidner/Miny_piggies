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
  #called before sql storage
  def pass_encryptor
    @password = BCrypt::Password.create(@password)
  end
   
  
  
  #SQL account creation
  def create_acc
    
    puts "First Name?"
      first = gets.chomp.downcase
    puts "last name?"
      last = gets.chomp.downcase
    puts "Email?(this will be used to login)"
      @email = gets.chomp.downcase
    puts "password?"
      @password = gets.chomp
    puts "password again"
      check_password = gets.chomp
    #handles password matching in a hacky way
    if match_pass?(check_password)
      #create account if its true
      pass_encryptor
     
      @db.execute('INSERT INTO accounts(email, password, first_name, last_name, total_val)
     VALUES(?,?,?,?,?);',[@email, @password, first, last, 0])
    else
      #just error out app for now
      print "passwords dont match"
      exit
    end
  end
  


    
end