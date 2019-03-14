require 'yaml'

key = "New Car"
goal_target = 15000

piggies = Hash.new

def create_piglet(piggies, key, goal)
  
  piglet = Hash.new
  piglet['current'] = 0
  piglet['goal'] = goal
  piggies[key] = piglet
  print piggies
end

create_piglet(piggies, 'Vacation', 3000)