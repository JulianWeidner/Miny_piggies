require './lib/classes/account.rb'
require './lib/modules/views.rb'

include Views

#Main method. The whole application comes together within this method. Change if you dare. 
def application
  start_input = Views.startup_view
  if start_input == 'login'
    #login
    email, pass = Views.login_input  #tupel
    
    user = Account.new(email, pass)
    user.login
    logoff = false
    #show financial and actions
    while logoff == false
      account_input = Views.account_view(user)
      case account_input
        when 'p-create'
          user.add_piglet(user.email)
          account_input= Views.account_view(user)
        when 'a-add'
          
          user.add_funds(univ_input.to_f)
          Account::sql_get_acc
        when 'a-withdraw'
          puts "| Withdraw amount: "
          withdraw_val = gets.chomp.to_f
          user.withdraw_funds(withdraw_val)
    
        when 'auto feed'
          puts "| This will be a percentage of each deposit made into the total account.\n| It will automatically allocate that money to the specified piglet (goal).\n"
          puts "| What Goal would you like to auto feed"
          goal = univ_input
          puts "| What percentage?(for 5% type: 5)"
          percentage = univ_input.to_i
          user.deposit_percentage(goal, percentage)
        
        when 'p-add'

          puts "| To which goal: "
          transfer_to = univ_input
          puts "| Transfer Amount: "
          transfer_amount = univ_input.to_i
          user.transfer_to_piggies(transfer_to, transfer_amount)
        when 'auto withdraw'
          puts ">>>> WIP"
          puts "| Goal to change: "
          goal = univ_input
          puts "| Percentage: "
          percentage = univ_input.to_i
          user.withdraw_percentage(goal, percentage)
        when 'lock piglet'
          puts ">>> WIP"
          puts "| Lock piglet(t/f): "
          piglet = univ_input
          application
        when 'logout'
          logout = true
        when 'test'
          disperse_val = user.auto_disperse(500)
          user.add_funds(disperse_val)  
        end
      end
    
    
  elsif start_input == 'create'
    log_out = false
    pass_check = nil
    print "| Email: "
    email = gets.chomp.downcase
    print "| Password: "
    password = gets.chomp
    print "| Re-type password: "
    repassword = gets.chomp
    password == repassword ? pass_check = true : pass_check = false
    if pass_check
      new_acc = Account.new(email, password)
      print %(| Welcome to Miny Piggies!
| What is your first name: )
      first = gets.chomp.downcase
      print "| What is your last name: "
      last = gets.chomp.downcase
      new_acc.create_acc(first, last)
      print "| Account Created!\n"
      application
    end 
  else
    puts "not coded"
    exit
  end
end

#Actually run application
application



