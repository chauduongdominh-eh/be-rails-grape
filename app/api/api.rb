# frozen_string_literal: true

class API < Grape::API
  format :json

  mount ::V1::NotesAPI
  add_swagger_documentation mount_path: '/api.json'
end
