# Unarchiver

A simple utility for consistently extracting and filtering the contents of zip files.

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG

## Usage

Initialize the unarchiver with a handle for the zip file and call
`expand` with an optional list of valid extensions to extract.

```ruby
Unarchiver.new(Rails.root.join("data/documents.zip")).expand(["pdf", "docx"])
```

Returns an array of tempfiles.  If passed a file which is not a zip,
it returns an array containing a new tempfile which wraps that file,
for consistency.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/botsandus/unarchiver. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/botsandus/unarchiver/blob/main/CODE_OF_CONDUCT.md).

## Licence

The gem is available as open source under the terms of the [Apache 2.0 licence](https://www.apache.org/licenses/LICENSE-2.0).

## Code of Conduct

Everyone interacting in the Unarchiver project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/botsandus/unarchiver/blob/main/CODE_OF_CONDUCT.md).
