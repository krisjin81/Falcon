if Rails.env.development?
  # Keys for localhost.
  Recaptcha.configure do |config|
    config.public_key  = '6LdPQ9MSAAAAAG8x_QBVPlxhcnDUvsn8EuHku4tl'
    config.private_key = '6LdPQ9MSAAAAABKIoayq5PF9nA8b_X-FEOb-9qFD'
  end
else
  # Keys configured for host.
  Recaptcha.configure do |config|
    config.public_key  = ENV['RECAPTCHA_PUBLIC_KEY']
    config.private_key = ENV['RECAPTCHA_PRIVATE_KEY']
  end
end
