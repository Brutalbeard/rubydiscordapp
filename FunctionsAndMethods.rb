def statExpand(stat)
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

input = gets.chomp
puts statExpand(input)
