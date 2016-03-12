# webapp
require_relative 'env'


class Realhack < Sinatra::Base
  get '/' do
    haml :index
  end
end
