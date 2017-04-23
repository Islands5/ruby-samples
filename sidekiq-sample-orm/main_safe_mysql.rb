require './worker.rb'

30.times do
  OurWorker.perform_async("safe", "mysql")
end

sleep 10
puts "###"
p User.last
User.delete_all
