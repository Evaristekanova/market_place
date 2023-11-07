class UserMailer < ApplicationMailer
    default from: ENV["GMAIL_USER"]

    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: "Welcome to our ecommerce!!!")
    end
end