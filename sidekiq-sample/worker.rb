require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://localhost:6379"}
end

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://localhost:6379"}
end

class OurWorker
  include Sidekiq::Worker

  @@mutex = Mutex.new

  def perform type
    case type
    when "unsafe"
      countup
    when "safe"
      @@mutex.synchronize { countup }
    end
    puts File.read("./counter").to_i
  end

  def countup
    File.open "./counter", File::Constants::RDWR | File::Constants::CREAT do |f|
      last_count = f.read.to_i
      f.rewind #=> ファイルの参照先を先頭にする
      f.write last_count + 1
    end
  end
end
