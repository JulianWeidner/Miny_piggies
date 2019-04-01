require 'yaml'

#Called via 'Views.login_input"
module Views
  
  #
  #Inputs
  #
  def login_input
    print "| Email: "
    email = gets.chomp.downcase
    print "| Password: "
    password = gets.chomp
    return email, password #Tupel example used here, assignment can be found at the top of the main application function
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
      exit #while loop
    else
      new_user = Account.new(email, pass).create_acc(first_name,last_name)
    end
  end

  def univ_input
    print "| Input: "
    gets.chomp
  end

  #
  #Views
  #|______________________ Center line
  def startup_view
    view = <<-string
 ____________________________________________
|                                            |
|                                            |
|                                            |
|                Miny Piggies                |
|                                            |
|                                            |
|                                            |
|                                            |
|        _____________________________       |
|       |            Login            |      |
|        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯       |
|        _____________________________       |
|       |        Create Account       |      |
|        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯       |
|        _____________________________       |
|       |            Help             |      |
|        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯       |
|                                            |
|____________________________________________|
  string
    print view
    print "|\n| INPUT(login,create,help): "
    input = gets.chomp.downcase
end


  def piglet_views(user_obj_parm)
    #load string
    piggies = user_obj_parm.piggies
    #convert to ruby hash
    ruby_piggies = YAML.load(piggies).to_a
    for piglet in ruby_piggies
      puts "|>#{piglet[0]}<"
      puts "| Piglet Value: #{piglet[1]['current_val']}"
      puts "| Piglet Goal: #{piglet[1]['target_val']}"
      puts "| Auto Feed Percentage: #{piglet[1]['deposit_percentage']}"
      puts "|_____________________"
    end
  end



  def account_view(user_obj_parm)
    user = user_obj_parm
    #prints data
    #write a loop for piglets 
  view = %(
 ____________________________________________
|                                            |
|  Account Value: $#{user.acc_val}                 
|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|
)
  action_views = %(
 _________
| ACTIONS |__________________________________|
|¯¯¯¯¯¯¯¯¯                                   |
|             | Piglet Actions |             |
|                                            |
| Create Piglet (P-Create)                   |
| Add Funds from Main Account (P-Add)        |
| Withdraw From Piglet (P-Withdraw)          |
| Delete Piglet (P-Delete)                   |
|                                            |
|             | Account Actions |            |
|                                            |
| Add funds (A-Add)                          |
| Withdraw Funds (A-Withdraw)                |
| Transfer To Piglet (A-Transfer)            | 
| Setup Auto Feed (A-Auto)                   | 
)
    print view
    piglet_views(user)
    print action_views
    print "| INPUT: "
    gets.chomp.downcase
  end


end