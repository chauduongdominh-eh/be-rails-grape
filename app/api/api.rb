# frozen_string_literal: true

class API < Grape::API
  format :json

  mount V1::Users
  mount V1::Notes
  add_swagger_documentation mount_path: '/api.json'
end
