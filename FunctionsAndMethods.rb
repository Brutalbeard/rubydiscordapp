def bonuses(player, stat)
    number = $redis.get "#{player}:#{stat}"
    return (number-10)/2
end

def statCheck(checkMe) #checks for a valid attribute, and returns that as lower case
  returnMe = nil
  returnMe = checkMe.match(/dex|con|int|str|wis|cha|name|all/i)

  if returnMe != nil
    return returnMe.to_s.downcase
  else
    return nil
  end
end

input = gets.chomp
fixed = statCheck(input)
