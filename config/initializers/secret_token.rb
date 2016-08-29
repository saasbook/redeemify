# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Auth::Application.config.secret_token = '08a0ac0362380c7255c4d72960b5b886ca9cbd3c66e10dcfb1cd6850c23612f9f8b32ed5db95a7845dcd8bfc779beac555692832e464018bc0510d81d579028d'

Auth::Application.config.secret_key_base = if Rails.env.development? or Rails.env.test? # generate simple key for test and development environments
  ('a' * 30) # should be at least 30 chars long
else
  ENV['SECRET_TOKEN']
end
