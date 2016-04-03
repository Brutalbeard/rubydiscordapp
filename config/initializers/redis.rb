#uri = URI.parse(ENV['REDIS_URL'])
#$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

$redis = Redis.new(url: ENV["REDIS_URL"])
#$redis = Redis.new(url: ENV["redis://h:p7jajl987e24uc5g5t45hu21ad@ec2-54-235-164-4.compute-1.amazonaws.com:2084"])
