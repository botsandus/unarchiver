# frozen_string_literal: true

require_relative "lib/unarchiver/version"

Gem::Specification.new do |spec|
  spec.name = "unarchiver"
  spec.version = Unarchiver::VERSION
  spec.authors = ["Elliot Crosby-McCullough"]
  spec.email = ["elliot@dexory.com"]

  spec.summary = "A small gem for extracting and filtering files from ZIPs"
  spec.homepage = "https://github.com/botsandus/unarchiver"
  spec.license = "Apache-2.0"
  spec.required_ruby_version = ">= 3.3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) { |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github Gemfile])
    end
  }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rubyzip", "~> 2.3"
end
