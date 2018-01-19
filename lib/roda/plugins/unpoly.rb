# frozen-string-literal: true
require "forwardable"
require "rack/unpoly/middleware"

class Roda
  module RodaPlugins
    # The unpoly plugin provides the necessary sugar to make Unpoly work seamlessly
    # with Roda.
    #
    #   plugin :unpoly
    module Unpoly
      class RodaInspector < DelegateClass(Rack::Unpoly::Inspector)
        attr_accessor :response # :nodoc:

        def initialize(obj, response)
          super(obj)
          @response = response
        end

        # Set the page title.
        def title=(value)
          set_title(response, value)
        end
      end

      module RequestMethods
        extend Forwardable

        def_delegators :up, :unpoly?, :up?

        # An instance of the +Inspector+.
        def up
          RodaInspector.new(env["rack.unpoly"], response)
        end
      end

      def self.configure(app, _opts={})
        app.use Rack::Unpoly::Middleware
      end
    end

    register_plugin :unpoly, Unpoly
  end
end
