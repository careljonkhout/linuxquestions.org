# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_linuxquestions.org_session',
  :secret      => '5c05f499402d8eca7477b72189ac9f3babb73030600f5b2d3c9e1a566fd3e6d090f91b282b1840f0659b7aca99b12a129d62b08cdc294a61c8054cf6f79e7163'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
