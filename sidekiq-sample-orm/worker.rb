require 'sidekiq'
require 'mongoid'
require 'active_record'
require 'active_support'
require 'yaml'

# sidekiq settings
Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379'}
end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379'}
end

# activerecord settings
conf = YAML.load_file('./config/database.yml')
ActiveRecord::Base.establish_connection(conf['db']['development'])

class User < ActiveRecord::Base
  self.table_name = 'users'
end


# mongoid settings
Mongoid.load!('./config/mongoid.yml', :development)

class UserMongo
  include Mongoid::Document
  field :seq, type: Integer
end

class OurWorker
  include Sidekiq::Worker

  @@mutex = Mutex.new

  def perform type, orm
    case type
    when "unsafe"
      countup orm
    when "safe"
      @@mutex.synchronize { countup orm }
    end
  end

  def countup orm
    case orm
    when 'mysql'
      user = User.first || User.create(seq: 0)
      user.increment!(:seq)
    when 'mongoid'
      user_mongo = UserMongo.first || UserMongo.create(seq: 0)
      user_mongo.inc(seq: 1)
    end
  end
end
