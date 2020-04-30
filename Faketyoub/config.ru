require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride #will allow us to send Patch and Delete Requests

#here is where we mount other controllers with use 

use CommentsController
use UsersController
use VideoController

run ApplicationController