class Roda
  module RodaPlugins
    module Unpoly
      module RequestMethods
        def unpoly?
          get_header("X-Up-Target").to_s.strip != ""
        end

        def unpoly
          response.headers["X-Up-Location"] = path
          response.headers["X-Up-Method"] = request_method

          if !get? && !unpoly?
            Rack::Utils.set_cookie_header!(response.headers, "_up_method", request_method)
          else
            Rack::Utils.delete_cookie_header!(response.headers, "_up_method")
          end
        end
      end
    end

    register_plugin :unpoly, Unpoly
  end
end
