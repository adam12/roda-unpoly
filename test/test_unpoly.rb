require "minitest/autorun"
require "rack/test"
require "roda"

class TestUnpoly < Minitest::Test
  include Rack::Test::Methods

  def app
    Class.new(Roda) do
      plugin :unpoly

      route do |r|
        r.get true do
          "Get"
        end
      end
    end
  end

  def test_plugin_adds_middleware
    get "/"

    refute_nil last_response.headers["X-Up-Method"]
  end
end
