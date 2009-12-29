# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hackerpolls_session',
  :secret      => 'dae2ac90b93469c45d69f06a97d79968fbf9943ae6308b2e28bc0ec411e5135ffe38b47336e907e42d138419eff536d519e2f3f3b986a04dae0b4b832faf3d3d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
