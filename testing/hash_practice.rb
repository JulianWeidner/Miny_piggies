require 'yaml'
require 'sqlite3'



@db = SQLite3::Database.open('test.db')



def create_piglet(piggies, key, goal)
  piglet = Hash.new
  piglet['current'] = 0
  piglet['goal'] = goal
  piglet['withdraw_percentage'] = 0
  piglet['deposite_percentage'] = 0
  piglet['locked'] = false
  puts piggies
  if piggies['piggies'] = ""
    piggies['piggies'] = {key => piglet}
  elsif piggies['piggies'] != ""
    piggies['piggies'].merge({key => piglet})
  end 
  #new piggies
  piggies
end

def create_account
  email = 'test'
  password = 'test'
  first = 'tester'
  last = 'tested'
  piggies = {"piggies" => "" }.to_yaml
  @db.execute('INSERT INTO accounts(email, password, first_name, last_name, total_val, piggies)
  VALUES(?,?,?,?,?,?);',[email, password, first, last, 0, piggies])
end

def update_piggies(ruby_hash, email)
  piggies = ruby_hash.to_yaml
  puts piggies
  @db.execute("UPDATE accounts SET piggies = ? WHERE email = ?",[piggies, email])
end
#add = create_piglet(piggies,'rent',500)
#piggies 
#yam = piggies.to_yaml
#print yam
#un_yam = YAML.load(yam)
#un_yam[:piggies] = add
#re_yammed = un_yam.to_yaml
#print re_yammed
# 
def piggies_to_ruby_hash(account)
  piggies_sql = @db.execute('SELECT piggies FROM accounts where email = ? ',[account])
  piggies_hash = YAML.load(piggies_sql[0][0])
  piggies_hash
end 



def add_piglet(email)
  #get origianl Piggies hash
  piggies_hash = piggies_to_ruby_hash(email)
  
  #get the information of the goal
  print "\n| Goal Name: "
  key = gets.chomp.capitalize
  print "\n| Target Amount: "
  goal_target = gets.chomp.to_i
  
  #create the ruby hash
  new_piggies_hash = create_piglet(piggies_hash, key, goal_target)
  update_piggies(new_piggies_hash, email)
  
  
  
 #piggies = @db.execute()
end

#load_piggies
#create_account
add_piglet('test')
add_piglet('test')