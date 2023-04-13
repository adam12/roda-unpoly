# frozen-string-literal: true

require "forwardable"
require "rack/unpoly/middleware"

class Roda
  module RodaPlugins
    # The unpoly plugin provides the necessary sugar to make Unpoly work seamlessly
    # with Roda.
    #
    # = Example
    #
    #   plugin :unpoly
    #
    #   route do |r|
    #     if r.up?
    #       "Unpoly request! :)"
    #     else
    #       "Not an Unpoly request :("
    #     end
    #   end
    module Unpoly
      # @see Rack::Unpoly::Inspector
      class RodaInspector < DelegateClass(Rack::Unpoly::Inspector)
        # @api private
        def initialize(obj, response)
          super(obj)
          @response = response
        end

        # Set the page title.
        #
        # @example
        #   r.up.title = "The new page title"
        #
        # @param value [String]
        def title=(value)
          set_title(response, value)
        end

        private

        attr_reader :response
      end

      module RequestMethods
        extend Forwardable

        # @!method unpoly?
        #   is an Unpoly request?
        #   @return [Boolean]
        # @!method up?
        #   is an Unpoly request?
        #   @return [Boolean]
        def_delegators :up, :unpoly?, :up?

        # An instance of the +Inspector+.
        # @return [RodaInspector]
        def up
          RodaInspector.new(env["rack.unpoly"], response)
        end
      end

      # @api private
      def self.configure(app, _opts = {})
        app.use Rack::Unpoly::Middleware
      end
    end

    register_plugin :unpoly, Unpoly
  end
end
