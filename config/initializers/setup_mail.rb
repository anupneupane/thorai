ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "thorai.team",
  :password             => "thorai3000",
  :authentication       => "plain",
  :enable_starttls_auto => true
}