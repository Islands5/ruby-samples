files = %w(hoge.txt fuga.txt)
threads = files.map {|file|
  Thread.fork {
    num = File.readlines(file).length
    "#{file}: #{num}"
  }
}

puts threads.map(&:value)
