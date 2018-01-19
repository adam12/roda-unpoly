# Unpoly for Roda

Easily add support for the server protocol expected by [Unpoly](http://unpoly.com).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "roda-unpoly"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install roda-unpoly

## Usage

Simply enable the plugin through the `plugin` mechanism.

```ruby
class App < Roda
  plugin :unpoly

  route do |r|
    # Routing tree
  end
end
```

Inside the routing tree, some convenience methods are made available to work with
the Unpoly request.

### Testing for Unpoly request

Use the methods `r.up?`, `r.unpoly?`, `r.up.up?`, or `r.up.unpoly?` (they are
all aliases of the same method).

### Testing the Unpoly target

Use the method `r.up.target?(your_target)`.

### Testing for Unpoly validate request

Use the method `r.up.validate?`.

### Setting page title

Use the method `r.up.title=`.

## Where are the Javascript and CSS assets?

I've chosen not to bundle those assets with the gem as they might be updated more
frequently then this library. Roda is also asset-agnostic (for the most part),
so it's easier if you bring in your assets as you see fit for your specific needs.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adam12/roda-unpoly.

I love pull requests! If you fork this project and modify it, please ping me to see
if your changes can be incorporated back into this project.

That said, if your feature idea is nontrivial, you should probably open an issue to
[discuss it](http://www.igvita.com/2011/12/19/dont-push-your-pull-requests/)
before attempting a pull request.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
