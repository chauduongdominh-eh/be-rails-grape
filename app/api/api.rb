# frozen_string_literal: true

class API < Grape::API
  version 'v1', using: :path
  format :json

  resources :notes do
    desc 'List user notes'
    get do
      Note.all
    end

    desc 'Get a specific note'
    params do
      requires :id, type: Integer, desc: 'Note ID'
    end
    route_param :id do
      get do
        Note.find(params[:id])
      end
    end
  end

  add_swagger_documentation
end
