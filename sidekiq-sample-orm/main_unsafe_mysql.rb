require './worker.rb'

30.times do
  OurWorker.perform_async("unsafe", "mysql")
end

sleep 10
puts "###"
p User.first
User.delete_all
