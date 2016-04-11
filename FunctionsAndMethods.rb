def rollNoBonus(player, diceAmount, diceType) #checks for a valid attribute, and returns that as lower case
  rolls = Array.new()
  text = String.new()
  text << "#{player} rolled #{diceAmount}, #{diceType} sided die...\n"
  totRoll = 0
 for i in 1..(diceAmount)
  rolls[i] = (rand(1..diceType))
  totRoll += rolls[i]
  text << "Roll #{i}: #{rolls[i]} \n"
 end
text << "\nTotal: #{totRoll}"
end

input1 = gets.chomp.to_i
input2 = gets.chomp.to_i
puts rollOff(input1, input2)
