require './worker.rb'

30.times do
  OurWorker.perform_async("unsafe", "mongoid")
end

sleep 10
puts "###"
p UserMongo.first
UserMongo.delete_all
