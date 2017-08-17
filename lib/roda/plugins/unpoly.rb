# frozen-string-literal: true

require "forwardable"

class Roda
  module RodaPlugins
    # The unpoly plugin provides the necessary sugar to make Unpoly work seamlessly
    # with Roda.
    #
    #   plugin :unpoly
    module Unpoly
      class Inspector
        extend Forwardable

        def_delegators :@context, :get_header, :response

        def initialize(context) # :nodoc:
          @context = context
        end

        # Determine if this is an Unpoly request.
        def unpoly?
          target.to_s.strip != ""
        end
        alias up? unpoly?

        # Identify if the +tested_target+ will match the actual target requested.
        def target?(tested_target)
          if up?
            actual_target = target

            if actual_target == tested_target
              true
            elsif actual_target == "html"
              true
            elsif actual_target == "body"
              !%w(head title meta).include?(tested_target)
            else
              false
            end
          else
            true
          end
        end

        # The actual target as requested by Unpoly.
        def target
          get_header("HTTP_X_UP_TARGET")
        end

        # Set the page title.
        def title=(new_title)
          response.headers["X-Up-Title"] = new_title
        end

        # Determine if this is a validate request.
        def validate?
          validate_name.to_s.strip != ""
        end

        # The name attribute of the form field that triggered
        # the validation.
        def validate_name
          get_header("HTTP_X_UP_VALIDATE")
        end
      end

      module RequestMethods
        extend Forwardable

        def_delegators :up, :unpoly?, :up?

        # Send the appropriate headers and cookies back to the client in order
        # to satisfy the contract of the Unpoly library. Called early in your
        # routing tree.
        def unpoly
          response.headers["X-Up-Location"] = url
          response.headers["X-Up-Method"] = request_method

          if !get? && !unpoly?
            Rack::Utils.set_cookie_header!(response.headers, "_up_method", { value: request_method, path: "/" })
          else
            Rack::Utils.delete_cookie_header!(response.headers, "_up_method", { path: "/" })
          end
        end

        # An instance of the +Inspector+.
        def up
          Inspector.new(self)
        end
      end
    end

    register_plugin :unpoly, Unpoly
  end
end
