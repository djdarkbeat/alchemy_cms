# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "alchemy/version"

Gem::Specification.new do |s|
  s.name                  = "alchemy_cms"
  s.version               = Alchemy::VERSION
  s.platform              = Gem::Platform::RUBY
  s.authors               = ["Thomas von Deyen", "Robin Boening", "Marc Schettke", "Hendrik Mans", "Carsten Fregin"]
  s.email                 = ["alchemy@magiclabs.de"]
  s.homepage              = "http://alchemy-cms.com"
  s.summary               = %q{A powerful, userfriendly and flexible CMS for Rails 4}
  s.description           = %q{Alchemy is a powerful, userfriendly and flexible Rails 4 CMS.}
  s.requirements         << 'ImageMagick (libmagick), v6.6 or greater.'
  s.required_ruby_version = '>= 1.9.3'
  s.license               = 'BSD New'

  s.files                 = `git ls-files`.split("\n")
  s.test_files            = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables           = 'alchemy'
  s.require_paths         = ["lib"]

  s.add_runtime_dependency %q<rails>,                            ["~> 4.0.0"]
  s.add_runtime_dependency %q<actionpack-page_caching>,          ["~> 1.0.0"]
  s.add_runtime_dependency %q<awesome_nested_set>,               ["~> 3.0.0.rc.1"]
  s.add_runtime_dependency %q<acts-as-taggable-on>,              ["~> 2.4.1"]
  s.add_runtime_dependency %q<cancan>,                           ["~> 1.6.10"]
  s.add_runtime_dependency %q<dragonfly>,                        ["~> 1.0.1"]
  s.add_runtime_dependency %q<kaminari>,                         ["~> 0.15.0"]
  s.add_runtime_dependency %q<acts_as_list>,                     ["~> 0.3.0"]
  s.add_runtime_dependency %q<magiclabs-userstamp>,              ["~> 2.0.2"]
  s.add_runtime_dependency %q<simple_form>,                      ["~> 3.0.0.rc"]
  s.add_runtime_dependency %q<jquery-rails>,                     ["~> 3.0.4"]
  s.add_runtime_dependency %q<jquery-ui-rails>,                  ["~> 3.0.1"]
  s.add_runtime_dependency %q<sass-rails>,                       ['~> 4.0.0']
  s.add_runtime_dependency %q<uglifier>,                         ['>= 1.3.0']
  s.add_runtime_dependency %q<coffee-rails>,                     ['~> 4.0.0']
  s.add_runtime_dependency %q<compass-rails>,                    ['~> 1.1.2']
  s.add_runtime_dependency %q<sassy-buttons>,                    ['~> 0.2.6']
  s.add_runtime_dependency %q<select2-rails>,                    ['~> 3.5.0']
  s.add_runtime_dependency %q<tvdeyen-handles_sortable_columns>, ['~> 0.1.5']
  s.add_runtime_dependency %q<spinner.rb>
  s.add_runtime_dependency "turbolinks", "~> 1.3.0"
  s.add_runtime_dependency "non-stupid-digest-assets", "~> 1.0.0"

  s.add_development_dependency %q<rspec-rails>
  s.add_development_dependency %q<capybara>
  s.add_development_dependency %q<factory_girl_rails>

end
