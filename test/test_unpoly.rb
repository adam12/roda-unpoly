require "minitest/autorun"
require "rack/test"
require "roda"

class TestUnpoly < Minitest::Test
  include Rack::Test::Methods

  def app
    Class.new(Roda) do
      plugin :unpoly

      route do |r|
        r.unpoly

        r.get "target", :target do |target|
          if r.up.target?(target)
            "Yep"
          else
            "Nope"
          end
        end

        r.get "validate" do
          if r.up.validate?
            "Validate"
          else
            "Nope"
          end
        end

        r.get "set-title" do
          r.up.title = "New Title"
          "Success"
        end

        r.post true do
          "Post"
        end

        r.get true do
          "Get"
        end
      end
    end
  end

  def test_unpoly_sets_method
    get "/"

    refute_nil last_response.headers["X-Up-Method"]
  end

  def test_unpoly_sets_location
    get "/"

    refute_nil last_response.headers["X-Up-Location"]
  end

  def test_unpoly_sets_cookie_on_non_get_requests
    post "/"

    assert_equal "_up_method=POST; path=/", last_response.headers["Set-Cookie"]
  end

  def test_unpoly_deletes_cookie_on_get_requests
    get "/"

    assert_match %r{_up_method=;}, last_response.headers["Set-Cookie"]
  end

  def test_set_title
    get "/set-title"

    refute_nil last_response.headers["X-Up-Title"]
  end

  def test_validate?
    get "/validate", {}, "HTTP_X_UP_VALIDATE" => true

    assert_equal "Validate", last_response.body
  end

  def test_targeteh_with_html_always_true
    get "/target/foo", {}, { "HTTP_X_UP_TARGET" => "html" }

    assert_equal "Yep", last_response.body
  end

  def test_targeteh_with_body_mostly_true
    get "/target/div", {}, { "HTTP_X_UP_TARGET" => "body" }

    assert_equal "Yep", last_response.body

    get "/target/head", {}, { "HTTP_X_UP_TARGET" => "body" }
    assert_equal "Nope", last_response.body
  end

  def test_targeteh_not_unpoly_request
    get "/target/dontmatter"

    assert_equal "Yep", last_response.body
  end
end
