require './worker.rb'

30.times do
  OurWorker.perform_async("unsafe")
end

sleep 10
puts "###"
puts File.read("./counter").to_i
File.delete "./counter"
