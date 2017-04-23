def countup
  File.open "#{Dir.pwd}/thread_safe/counter", File::Constants::RDWR | File::Constants::CREAT do |f|
    last_count = f.read.to_i
    f.rewind #=> ファイルの参照先を先頭にする
    f.write last_count + 1
  end
end

mutex = Mutex.new

10.times.map {
  Thread.fork {
    mutex.synchronize { countup }
  }
}.map(&:join)

puts File.read("#{Dir.pwd}/thread_safe/counter").to_i
File.delete "#{Dir.pwd}/thread_safe/counter"
