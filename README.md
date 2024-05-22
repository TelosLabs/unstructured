# Unstructured
This is a Ruby client for the [Unstructured API](https://unstructured-io.github.io/unstructured/api.html).

## Installation

Install the gem and add to the application's Gemfile by executing:
```
    $ bundle add unstructured
```

If bundler is not being used to manage dependencies, install the gem by executing:
```
    $ gem install unstructured
```

## Usage
```ruby
server_url = "https://api.unstructured.io" # "http://localhost:8000" if you are running a docker container
client = Unstructured::Client.new(server_url: server_url, api_key: ENV["UNSTRUCTURED_API_KEY"])

file_path = "./your_document.pdf"
params = {
  strategy: "fast",
  hi_res_model_name: "yolox",
  pdf_infer_table_structure: true,
  chunking_strategy: "by_title",
  max_characters: 1000,
  new_after_n_chars: 1000
}
chunks = client.partition(file_path, params)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TelosLabs/unstructured.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
