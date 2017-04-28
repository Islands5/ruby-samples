require './worker.rb'

30.times do
  OurWorker.perform_async("safe")
end

sleep 5
puts "###"
puts File.read("./counter").to_i
File.delete "./counter"
