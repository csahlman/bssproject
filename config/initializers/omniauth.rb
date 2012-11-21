Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  # provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  # provider :open_id, :store => OpenID::Store::Filesystem.new('/tmp')
    # provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET,
  #   scope: 'email,username,name'
end