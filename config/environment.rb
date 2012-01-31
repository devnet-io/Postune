# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Postune::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.gmail.com',
    :domain         => 'postune.com',
    :port           => 587,
    :user_name      => 'ferrist@postune.com',
    :password       => '#YI2san4',
    :authentication => :plain
}