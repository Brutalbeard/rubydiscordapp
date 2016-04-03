uri = URI.parse(ENV["redis://h:p7jajl987e24uc5g5t45hu21ad@ec2-54-235-164-4.compute-1.amazonaws.com:2084"])
$redis = Redis.new(:host => ec2-54-235-164-4.compute-1.amazonaws.com, :port => 20849, :password => "p7jajl987e24uc5g5t45hu21ad")


#$redis = Redis.new(url: ENV["redis://h:p7jajl987e24uc5g5t45hu21ad@ec2-54-235-164-4.compute-1.amazonaws.com:2084"])
