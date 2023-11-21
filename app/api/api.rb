# frozen_string_literal: true

require 'grape-swagger'
require 'grape_logging'

class API < Grape::API
  format :json
  default_format :json
  content_type :json, 'application/json'
  include ExceptionsHandler

  logger.formatter = GrapeLogging::Formatters::Default.new

  logger_options = [GrapeLogging::Loggers::FilterParameters.new]
  unless Rails.env.production?
    logger_options << GrapeLogging::Loggers::Response.new
    logger_options << GrapeLogging::Loggers::RequestHeaders.new
  end
  insert_before Grape::Middleware::Error,
                GrapeLogging::Middleware::RequestLogger,
                { logger:, include: logger_options }

  helpers GlobalHelpers

  # mount Endpoints::Root
  mount Endpoints::Users
  mount Endpoints::Channels
  mount Endpoints::Locations
  mount Endpoints::Stores
  # mount Endpoints::QualityLabAPI::Base

  # mount Endpoints::Clients
  # mount Endpoints::Staffs
  # mount Endpoints::WorkingTimes

  add_swagger_documentation(
    format: :json,
    # hide_documentation_path: false,
    array_use_braces: true,
    info: {
      title: 'Horses and Hussars',
      description: 'Demo app for dev of grape swagger 2.0'
    },
    mount_path: 'swagger'
  )
end
