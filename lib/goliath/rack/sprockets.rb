module Goliath
  module Rack
    class Sprockets
      include Goliath::Rack::AsyncMiddleware

      def post_process(env, status, headers, body)
        environment = ::Sprockets::Environment.new
        environment.cache = ::Sprockets::Cache::FileStore.new("/tmp")
        environment.append_path 'assets/javascripts'
        environment.append_path 'assets/stylesheets'
        environment.append_path 'assets/images'
        environment.call(env)
      end
    end
  end
end