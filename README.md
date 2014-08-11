# Capistrano3::Copy

A very simple gem providing a copy strategy for Capistrano3

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano3-copy'

And then execute:

    $ bundle

## Usage

In your config/deploy.rb file change your strategy to copy with this line:

    set :scm, 'copy'

That's it!
Next time you deploy, you will create a zip file, copy it over and
unpack it in your server.

By default the zip file is created and left in release.zip in the same
directory of your project, if you would like to use a different
location, you can overwrite the default with:

    set :copy_local_file, '/tmp/out_of_sight'

By default all files but files in the log/ directory are copied over, if
you want to change that, you can define any reg expresion with the files
you want to exclude with:
    set :copy_exclude, /\.log$/

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capistrano3-copy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
