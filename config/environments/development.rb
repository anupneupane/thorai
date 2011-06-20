Purchest::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  # change localhost:3000 to your website domain
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  
#  require 'rack/ssl'
#  config.middleware.use Rack::SSL
  
  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    
    ::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
    	:login => "vinaya_1308408534_biz_api1.gmail.com",
    	:password => "ZF6HJPRUNZ2KK9G3",
    	:signature => "Ai3xbkJ1IfQgDhjwJH6NO9WXYTfuAlkTef84gG3zUIyIXej2rf3nPq44"
    )
  end
  
  config.to_prepare do
    OrderTransaction.gateway = ActiveMerchant::Billing::BraintreeGateway.new(
                                  :login => '',
                                  :password => '' 
                                )
  end
  
end

