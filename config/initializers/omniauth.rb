Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '417670204969512', '22ab2b6a57a9ddad071b18ec22136148'
end