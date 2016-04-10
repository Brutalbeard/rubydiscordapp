def statCheck(checkMe)
  returnMe = nil
  returnMe = checkMe.match(/dex|con|int|str|wis|cha/i)

  if returnMe != nil
    return returnMe.to_s.downcase
  else
    return "Invalid option"
  end
end

input = gets.chomp
puts statCheck(input)
