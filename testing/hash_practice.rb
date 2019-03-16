require 'yaml'
require 'sqlite3'



@db = SQLite3::Database.open('test.db')
#just used when I need to update the DB schema and I need my test accc set
 
def create_account
  email = 'test'
  password = 'test'
  first = 'tester'
  last = 'tested'
  piggies = {}
  @db.execute('INSERT INTO accounts(email, password, first_name, last_name, total_val, piggies)
  VALUES(?,?,?,?,?,?);',[email, password, first, last, 0, piggies.to_yaml])
end


#writes to sql
def update_piggies(ruby_hash, email)
  piggies = ruby_hash.to_yaml
  puts piggies
  @db.execute("UPDATE accounts SET piggies = ? WHERE email = ?",[piggies, email])
end

#reads sql
def piggies_to_ruby_hash(account)
  piggies_sql = @db.execute('SELECT piggies FROM accounts where email = ? ',[account])
  #print YAML.load(piggies_sql[0][0])
  return YAML.load(piggies_sql[0][0])
 
end 


def add_piglet(email)
  #get the hash from the account
  piggies_hash = piggies_to_ruby_hash(email)
  puts piggies_hash
  #gets piglet info
  print "| Goal Name: "
  goal_name = gets.chomp.downcase
  print "| Goal target: "
  target_val = gets.chomp.to_i
  #blank or already filled piglet container hash
  piggies = piggies_hash

  #initalize a piglet with the follow values
  piglet = {goal_name => {
  'current_val' => 0, 
  'target_val' => target_val,
  'withdraw_percentage' => 0,
  'deposit_percentage' => 0,
  'locked'  => false}}

 
  #if it is a new account and has 0 piglets merge wont work on a nil hash, so I set it equal to the new hash. 
  if piggies.any?
    piggies.merge()
  else 
    new_piggies = piggies['hash'] = {'piggies' => piglet}
    update_piggies(new_piggies, email)
  end

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



#create_account
add_piglet('test')



