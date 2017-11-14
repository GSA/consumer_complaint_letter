# Be sure to restart your server when you modify this file.

CahRails::Application.config.session_store :cookie_store, key: '_cah_rails_session', :secure => true, :httponly => true

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# CahRails::Application.config.session_store :active_record_store
