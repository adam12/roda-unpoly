# frozen-string-literal: true

require "forwardable"

class Roda
  module RodaPlugins
    module Unpoly
      class Inspector
        extend Forwardable

        def_delegators :@context, :get_header, :response

        def initialize(context)
          @context = context
        end

        def unpoly?
          get_header("X-Up-Target").to_s.strip != ""
        end
        alias up? unpoly?

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

        def target
          get_header("X-Up-Target")
        end

        def title=(new_title)
          response.headers["X-Up-Title"] = new_title
        end

        def validate?
          get_header("X-Up-Validate").to_s.strip != ""
        end
      end

      module RequestMethods
        extend Forwardable

        def_delegators :up, :unpoly?, :up?

        def unpoly
          response.headers["X-Up-Location"] = path
          response.headers["X-Up-Method"] = request_method

          if !get? && !unpoly?
            Rack::Utils.set_cookie_header!(response.headers, "_up_method", request_method)
          else
            Rack::Utils.delete_cookie_header!(response.headers, "_up_method")
          end
        end

        def up
          Inspector.new(self)
        end
      end
    end

    register_plugin :unpoly, Unpoly
  end
end
