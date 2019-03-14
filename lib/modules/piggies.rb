#This module is used for changing values within the SQL blob
module Piggies
  def store_piglet(new_val)
      @db.execute('UPDATE accounts SET piggies = ? WHERE email = ?',[new_val, @email])
  end
  
  def create_piglet(piggies_hash, key, goal)
    piglet = Hash.new
    piglet['goal'] = goal
    piglet['current'] = 0
    piggies_hash = piglet
    store_piglet(piggies_hash)
  end
  
  def get_piggies_yaml
    pigges.to_yaml
  end
  
  
    private :store_piglet
end