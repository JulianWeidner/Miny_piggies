require 'yaml'
require 'sqlite3'



@db = SQLite3::Database.open('test.db')




def add_piglet(piggies_parm, goal_name, target_val)
  #blank or already filled piglet container hash
  piggies = piggies_parm
  piglet = {goal_name => {
  'current_val' => 0, 
  'target_val' => target_val,
  'withdraw_percentage' => 0,
  'deposit_percentage' => 0,
  'locked'  => false}}

  if piggies.any?
    return piggies['piggies'].merge!(piglet)
  else 
    return piggies['piggies'] = piglet
  end
end

def create_account
  email = 'test'
  password = 'test'
  first = 'tester'
  last = 'tested'
  piggies = Hash.new
  @db.execute('INSERT INTO accounts(email, password, first_name, last_name, total_val, piggies)
  VALUES(?,?,?,?,?,?);',[email, password, first, last, 0, piggies.to_yaml])
 
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



puts "Goal name?"
goal = gets.chomp.downcase
puts "Target Value"
targ_val = gets.chomp.to_i

add_piglet(piggies_to_ruby_hash('test'), goal, targ_val)
