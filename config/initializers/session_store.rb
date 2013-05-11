# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_shopping_session',
  :secret      => '89643d147278135d7b8d5786e66393562e7dfe1d3db9505b673383ec35e32d952b0c6cda6c15b986408bbe12fcc9eb9cb3d4783489ed48fdecc5f83099b69c30'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
