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
    #show financial and actions
    account_input = Views.account_view(user)
    case account_input
      when 'create'
        user.add_piglet(user.email)
      when 'add funds'
        puts "How much money are you adding?"
        user.add_funds(univ_input.to_i)
      when 'withdraw funds'
        puts "How much money are you withdrawing?"
        user.piggies_percentage
        puts
        user.withdraw_funds(univ_input.to_i)
      when 'auto feed'
        puts "| This will be a percentage of each deposit made into the total account.\n| It will automatically allocate that money to the specified piglet (goal).\n"
        puts "| What Goal would you like to auto feed"
        goal = univ_input
        puts "| What percentage?(for 5% type: 5)"
        percentage = univ_input.to_i
        user.deposit_percentage(goal, percentage)
      when 'transfer'
        puts ">>>>>>>>> Currently only gets from the accounts total val"
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
      when 'test'
        disperse_val = user.auto_disperse(500)
        user.add_funds(disperse_val)
        
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
      print "| Account Created!"
    end 
  else
    puts "not coded"
    exit
  end
end

#Actually run application
application



