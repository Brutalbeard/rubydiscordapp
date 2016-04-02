require 'sinatra'
require 'discordrb' #uber fancy and useable library
require 'json'
require 'open-uri'
require 'pstore'
require 'redis'

bot = Discordrb::Commands::CommandBot.new("jceloria@icloud.com", "bitemeweirddude", "/", {advanced_functionality: false}) #credentials for login, the last string is the thing you have to type to run our commands.


#bot.message(containing: "test") do |event| #obvious test message. Leaving it in here as 'message' works slightly differently from command.
#  event.respond "Your test worked- even though fletcher is in bed"
#end

bot.message(from: not!("Iblan"), containing: "Suck it Ian!") do |event| #Will probably make this cooler. You'll see.
  event.respond "#{event.author.mention} fires an arrow at Ian!"
end

bot.message(from: "Iblan", containing: "Suck it") do |event|
  event.respond "Shut up Ian."
end

bot.command(:shoot, description: "Shoots and arrow at whoever, or whatever you want", usage: "Type /shoot Ian") do |event, arg|
  "#{event.author.mention} shoots an arrow at #{arg} for #{rand(1..8)} damage!"
end

bot.command(:roll, description: "Returns a roll.", usage: "Type /roll 1d20 as an example") do |event, arg| # so the description and the usage are both for help. That's something the message above doesn't have. Event means, it happened I guess? Little fuzzy there. Then the 'arg' is whatever they type in after calling the command. Which runs through old faithful down below.
  if arg.match(/\d{1,}[d]\d{1,2}/) == nil
    text = "Wrong syntax. Try /help roll"
  else
    diceAmount = arg.split("d")[0].to_i
    diceType = arg.split("d")[1].to_i
    rolls = Array.new()
    text = String.new()
    text << "#{event.user.name} rolled #{diceAmount}, #{diceType} sided die...\n"
    totRoll = 0
   for i in 1..(diceAmount)
    rolls[i] = (rand(1..diceType))
    totRoll += rolls[i]
    text << "Roll #{i}: #{rolls[i]} \n"
   end
  text << "\nTotal: #{totRoll}"
  end
  text #so this also differs from the messages above. Don't have to put event.respond. That's what was causing those double responses earlier. Just put the variable adter the last 'end' which closes out the 'do' at the top. Then it sends back that variable. Boom.
end

#Functional remote update from github. No redundancy though. If github re-write crashes on startup, have to remote into the RPi and restart manually using
#cd Discord\ App
#nohup ruby RollToDodge.rb
#Took out update

bot.command(:define, description: "Defines a word using Urban Dictionary", usage: "/define chode") {|event, *args|

  args = args.join(' ')

  def parse(string)
    val = JSON.parse(string)
    #puts "After Parse: #{val}"
    val
    rescue
      "No Definition Found"
  end

  def get_uri(uri)
    val = open(uri).read
    #puts "Value Returned By URI: #{val}"
    val
  end

  def urbandictionary_uri(args)
    "http://api.urbandictionary.com/v0/define?term=#{args}"
  end

  event << "#{args.split.map(&:capitalize).join(' ')}: \n"
  #event << parse(open("http://api.urbandictionary.com/v0/define?term=#{arg}").read)['definition']
  event << parse(get_uri(urbandictionary_uri(args)))['list'].first['definition']}

bot.command(:whoami, description: "Gives your name and user ID. Also tells you your chat channel and game you're playing", usage: "/whoami") do |event|
  event.respond "User Name: #{event.user.name}\n"
  #event.respond "#{event.user.status}\n"
  event.respond "User ID: #{event.user.id}\n"
  if event.user.voice_channel != nil
    event.respond "Talking in: #{event.user.voice_channel}"
  end
  if event.user.game != nil
    event.respond "Playing: #{event.user.game}"
  end
end

bot.command(:whois, descrption: "Gives you the useful info about your cohorts", usage: "/whois @RollToDodge") do |event, arg|
  user1 = bot.parse_mention(arg)
  event.respond "User Name: #{user1.name} \n"
  event.respond "#{user1.status}\n"
  event.respond "User ID: #{user1.id}\n"
  if user1.voice_channel != nil
    event.respond "Talking in: #{user1.voice_channel.name}"
  end
  if user1.game != nil
    event.respond "Playing: #{user1.game}"
  end
end

#set Tom up with Appendages so we can remove them!
appendages = PStore.new("appendages.pstore")
appendages.transaction do
  appendages[:one] = "Left Arm"
  appendages[:two] = "Right Arm"
  appendages[:three] = "Left Leg"
  appendages[:four] = "Right Leg"
  appendages[:five] = "Middle LEG"
end

bot.command(:lop, description: "Takes an Appendage from Tom.", usage: "/lop") do |event|
  a = String.new()
  roll = rand(1..5)
  case roll
    when 1
      a = "one"
    when 2
      a = "two"
    when 3
      a = "three"
    when 4
      a = "four"
    when 5
      a = "five"
  end

  appendages.transaction do
    lost = appendages.fetch(:"#{a}")
    "Tom lost his #{lost}"
  end
end

bot.command(:bow, description: "Gives a random bow gif", usage: "/bow") do |event|
  api_key = "dc6zaTOxFJmzC"

  searchFor = "bow"

  giphyRequest = "http://api.giphy.com/v1/gifs/search?q=#{searchFor}&api_key=#{api_key}"

  def parse(string)
    val = JSON.parse(string)
    #puts "After Parse: #{val}"
    val
    rescue
      "No Definition Found"
  end

  def get_uri(uri)
    val = open(uri).read
    #puts "Value Returned By URI: #{val}"
    val
  end

  event << parse(get_uri(giphyRequest))['data'].sample['images']['original']['url']

end

bot.command(:gifme, description: "Gives you a random gif based off what you type", usage: "/gifme stupid people") do |event, *args|
  api_key = "dc6zaTOxFJmzC"

  searchFor = args.join('+')

  giphyRequest = "http://api.giphy.com/v1/gifs/search?q=#{searchFor}&api_key=#{api_key}"

  def parse(string)
    val = JSON.parse(string)
    #puts "After Parse: #{val}"
    val
    rescue
      "No Definition Found"
  end

  def get_uri(uri)
    val = open(uri).read
    #puts "Value Returned By URI: #{val}"
    val
  end

  event << parse(get_uri(giphyRequest))['data'].sample['images']['original']['url']

end

bot.command(:makeMe, description: "Initializes your character sheet", usage: "/makeMe Connor") do |event, *args|
  player = PStore.new("#{event.user.id}.pstore")
  player.transaction do
    player[:name] = args.join(' ')
  end
  player.transaction {player[:name]}
end

bot.command(:makeStat, description: "Generates a stat, checks for preexisting.", usage: "/makeStat con 10") do |event, *args|
  player = PStore.new("#{event.user.id}.pstore")
  statName = checkValidStat(args[0])
  if statName == nil
    "#{args[0]} is not a valid Attribute"
  else
    player.transaction do
      if player.root?(:"#{statName}") == true
        "#{statName} already exists!"
      else
        player[:"#{statName}"] = args[1]
      end
    end
  end
end

bot.command(:changeStat, description: "If you screwed the pooch, ask Johnny or Fletcher to fix your crap with this.", usage: "@BrutalBeard please change my dex to 11? I owe you a bj. Brutalbeard: /changeStat @loser dex 11 ") do |event, *args|
  authUsers = [150283399192510464, 143886187122262017]
  if(authUsers.include? event.user.id)
    chgTarget = bot.parse_mention(args[0])
    player = PStore.new("#{chgTarget.id}.pstore")
    statName = checkValidStat(args[1])
    if statName == nil
      "#{args[0]} is not a valid Attribute"
    else
      player.transaction do
        player[:"#{statName}"] = args[2]
      end
    end
  else
    "Unauthorized user. Get hosed biatch."
  end
end


bot.command(:showMe, description: "Tells you one of your stats", usage: "/showMe name, or /showMe con") do |event, arg|
  player = PStore.new("#{event.user.id}.pstore")
  statName = checkValidStat(arg)
  if statName == nil
    "#{arg} is not a valid Attribute"
  else
    player.transaction do
      if player.root?(:"#{statName}") == false
        "--Did you mean /makeStat?"
      else
      "#{player[:name]}'s #{arg.capitalize} is #{player[:"#{statName}"]}. The bonus is #{(player[:"#{arg}"].to_i-10)/2}."
      end
    end
  end
end


bot.run
