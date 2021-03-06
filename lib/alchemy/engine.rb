# Require globally used external libraries
require 'actionpack/page_caching'
require 'action_view/dependency_tracker'
require 'cancan'
require 'coffee-rails'
require 'compass-rails'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'kaminari'
require 'sass-rails'
require 'sassy-buttons'
require 'simple_form'
require 'select2-rails'
require 'turbolinks'
require 'userstamp'
require 'non-stupid-digest-assets'

# Require globally used Alchemy mixins
require 'alchemy/auth_accessors'
require 'alchemy/cache_digests/template_tracker'
require 'alchemy/config'
require 'alchemy/errors'
require 'alchemy/essence'
require 'alchemy/filetypes'
require "alchemy/forms/builder"
require 'alchemy/i18n'
require 'alchemy/logger'
require 'alchemy/modules'
require 'alchemy/mount_point'
require 'alchemy/name_conversions'
require 'alchemy/page_layout'
require 'alchemy/permissions'
require 'alchemy/picture_attributes'
require 'alchemy/resource'
require 'alchemy/tinymce'
require 'alchemy/touching'

# Require hacks
require 'alchemy/kaminari/scoped_pagination_url_helper'
require File.join(File.dirname(__FILE__), '../extensions/action_view')

module Alchemy
  class Engine < Rails::Engine
    isolate_namespace Alchemy
    engine_name 'alchemy'
    config.mount_at = '/'

    # Enabling assets precompiling
    initializer 'alchemy.assets' do |app|
      app.config.assets.precompile += [
        "alchemy/alchemy.js",
        "alchemy/preview.js",
        "alchemy/admin.css",
        "alchemy/menubar.css",
        "alchemy/menubar.js",
        "alchemy/print.css",
        "tinymce/*"
      ]
    end

    initializer 'alchemy.dependency_tracker' do |app|
      [:erb, :slim, :haml].each do |handler|
        ActionView::DependencyTracker.register_tracker(handler, CacheDigests::TemplateTracker)
      end
    end

    initializer 'alchemy.non_digest_assets' do |app|
      NonStupidDigestAssets.whitelist = ['tinymce/']
    end

    config.after_initialize do
      require 'alchemy/userstamp'
      # We need to reload the routes, because alchemy extensions (i.e. alchemy-devise) prepends routes.
      Rails.application.routes_reloader.reload!
    end
  end
end
