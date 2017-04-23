require 'benchmark'

def countup
  File.open "#{Dir.pwd}/bench/counter", File::Constants::RDWR | File::Constants::CREAT do |f|
    sleep 1
    last_count = f.read.to_i
    f.rewind #=> ファイルの参照先を先頭にする
    f.write last_count + 1
  end
end


Benchmark.bm 6 do |r|
  r.report "unsafe" do
    10.times.map {
      Thread.fork { countup }
    }.map(&:join)

    puts File.read("#{Dir.pwd}/bench/counter").to_i    
    File.delete "#{Dir.pwd}/bench/counter"
  end
  
  r.report "safe" do
    mutex = Mutex.new
    10.times.map {
      Thread.fork {
        mutex.synchronize { countup }
      }
    }.map(&:join)
    
    puts File.read("#{Dir.pwd}/bench/counter").to_i    
    File.delete "#{Dir.pwd}/bench/counter"
  end
end
