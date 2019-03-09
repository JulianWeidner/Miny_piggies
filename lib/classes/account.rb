class Account
  
  def initialize(email_parm, password_parm)
    @email = email_parm
    @password = password_parm
  end
  
  
  #accessors
  def email; @email end
  def password; @password end
    
end