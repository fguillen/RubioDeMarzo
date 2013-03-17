RubioDeMarzo::Application.config.middleware.use(
  ExceptionNotifier,
  :email_prefix => "[RubioDeMarzo] ",
  :sender_address => APP_CONFIG[:admin_email],
  :exception_recipients => [APP_CONFIG[:admin_email]]
)
