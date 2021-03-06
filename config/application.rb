require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PostTracker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.autoload_paths << Rails.root.join('lib/notifier')
    config.assets.enabled = true
    config.autoload_paths += %W(#{config.root}/app/classes)
    config.autoload_paths += %W(#{config.root}/app/assets/fonts)
    config.autoload_paths += %W(#{config.root}/lib/modules)
    config.load_defaults 5.1


    # See this link: http://guides.rubyonrails.org/action_mailer_basics.html
    config.action_mailer.default_url_options = { host: Figaro.env.website_domain }
    config.action_mailer.asset_host = Figaro.env.website_domain




    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
