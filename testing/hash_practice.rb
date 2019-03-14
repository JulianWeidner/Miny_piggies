require 'yaml'
require 'sqlite3'

key = "save"
goal_target = 200

piggies = Hash.new

def create_piglet(piggies, key, goal)
  piglet = Hash.new
  piglet['current'] = 0
  piglet['goal'] = goal
  piglet['percentage'] = 0
  piglet['locked'] = false
  piggies[key] = piglet
  piggies
end

create_piglet(piggies, key, goal_target)
@db = SQLite3::Database.open('test.db')

def create_account
  email = 'test'
  password = 'test'
  first = 'tester'
  last = 'tested'
  piggies = {piggies: "" }.to_yaml
  @db.execute('INSERT INTO accounts(email, password, first_name, last_name, total_val, piggies)
  VALUES(?,?,?,?,?,?);',[email, password, first, last, 0, piggies])
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
def piggies_to_rb(email)
  piggies_sql = @db.execute('SELECT piggies FROM accounts where email = ? ',[email])
  piggies_string = piggies_sql
  print piggies_string[0].class
  
end 



def add_piglet
 piggies = @db.execute()
end

#load_piggies
#create_account
piggies_to_rb('test')