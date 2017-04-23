require 'mongoid'

Mongoid.load!('./config/mongoid.yml', :development)

class UserMongo
  include Mongoid::Document
  field :seq, type: Integer
end
