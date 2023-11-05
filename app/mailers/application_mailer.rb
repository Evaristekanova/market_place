class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name("ishamitech6@gmail.com", "Evariste from ecommerce")
  layout "mailer"
end
