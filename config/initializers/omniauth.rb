OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '125644104300196', 'e7e20d81b70d12c80aad94a85853f0db'
end