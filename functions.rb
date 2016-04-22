def statCheck(checkMe) #checks for a valid attribute, and returns that as lower case
  returnMe = nil
  returnMe = checkMe.match(/dex|con|int|str|wis|cha|name|all/i)

  if returnMe != nil
    return returnMe.to_s.downcase
  else
    return nil
  end
end

def statExpand(stat) #expands from cha to Charisma. So forth.
  case stat
  when 'dex'
    return "Dexterity"
  when 'int'
    return "Intelligence"
  when 'con'
    return "Constitution"
  when 'wis'
    return "Wisom"
  when 'str'
    return "Strength"
  when 'cha'
    return "Charisma"
  else
    return "hi!"
  end
end

def bonuses(player, stat) #reusable stat bonus
    number = $redis.get "#{player}:#{stat}"
    return (number.to_i-10)/2
end
