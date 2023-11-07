require "active_support/core_ext/integer/time"

Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true

  config.server_timing = true

  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.active_storage.service = :local

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :smtp
  host = "localhost:3000"
  config.action_mailer.default_url_options = { host: host }

  # SMTP settings for gmail
  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               "gmail.com",
    user_name:            ENV["GMAIL_USER"],
    password:             ENV["GMAIL_PASSWORD"],
    authentication:       "plain",
    enable_starttls_auto: true
  }

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.example.com',
    port: 587,                
    domain: "gmail.com",
    user_name: ENV.fetch("GMAIL_USER", nil),
    password: ENV.fetch("GMAIL_PASSWORD", nil),
    authentication: 'plain',
    enable_starttls_auto: true
  }


  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :log

  config.active_support.disallowed_deprecation = :raise

  config.active_support.disallowed_deprecation_warnings = []

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true
end
