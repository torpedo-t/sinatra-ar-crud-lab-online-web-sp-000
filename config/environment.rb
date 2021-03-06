ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

def fi_check_migration
  begin
    ActiveRecord::Migration.check_pending!
  rescue ActiveRecord::PendingMigrationError
    raise ActiveRecord::PendingMigrationError.new "Migrations are pending.\nTo resolve this issue, run: \nrake db:migrate SINATRA_ENV=#{ENV['SINATRA_ENV']}"
  end
end

#1. After you download the gem "activerecord" we have to tell the program which database to connect, 
# so we can put the following statement in 'environment.rb'
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'
