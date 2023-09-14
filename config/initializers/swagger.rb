# frozen_string_literal: true

GrapeSwaggerRails.options.url = '/api/swagger_doc'
GrapeSwaggerRails.options.app_url = URI::HTTP.build(Rails.application.routes.default_url_options).to_s
GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end
GrapeSwaggerRails.options.api_auth = 'Bearer' # Or 'bearer' for OAuth
GrapeSwaggerRails.options.api_key_name = 'Authorization'
GrapeSwaggerRails.options.api_key_type = 'header'
