ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: "587",
  enable_starttls_auto: true,
  authentication: :plain,

  # Do not ever put
  # Because if you commit it and send it to Github, it's public.
  # never, ever, commit confidential information.
  # People create bots to comb Github for confidential info.
  # Environment variables are essentially global variables accessible within your shell.
  # Type 'env' in shell

  # Type process.env

  # Good place to store any confidential information for any programming language.
  user_name: ENV["EMAIL_USERNAME"],
  password: ENV["EMAIL_PASSWORD"]
}