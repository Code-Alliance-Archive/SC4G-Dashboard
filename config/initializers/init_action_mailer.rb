ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default :charset => "utf-8"
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :port           => 587,
  :domain         => 'gmail.com',
  :user_name      => 'rails.4.charity.test@gmail.com',
  :password       => 'rails4charity',
  :authentication => :plain,
  :enable_starttls_auto => true
}