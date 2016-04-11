def showAll(player) #checks for a valid attribute, and returns that as lower case
  dex = $redis.get "#{player}:dex"
  name = $redis.get "#{player}:name"
  con = $redis.get "#{player}:con"
  int = $redis.get "#{player}:int"
  wis = $redis.get "#{player}:wis"
  str = $redis.get "#{player}:str"
  cha = $redis.get "#{player}:cha"
  """Name: #{name}
  Dexterity: #{dex}
  Constitution: #{con}
  Intelligence: #{int}
  Wisdom: #{wis}
  Strength: #{str}
  Charisma: #{cha}"""
end

input = gets.chomp
fixed = statCheck(input)
