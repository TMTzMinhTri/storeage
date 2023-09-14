class API < Grape::API
  format :json

  mount V1::Root
  add_swagger_documentation
end
