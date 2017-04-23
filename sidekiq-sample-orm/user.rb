require 'active_record'
require 'yaml'

conf = YAML.load_file('./config/database.yml')
ActiveRecord::Base.establish_connection(conf['db']['development'])


class User < ActiveRecord::Base
    self.table_name = 'users'
end
