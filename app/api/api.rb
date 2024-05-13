class API < Grape::API
  version 'v1', using: :header, vendor: 'EH'
  format :json

  resources :notes do
    desc 'List user own notes'
    get do
      []
    end

    desc 'Get a specific note'
    params do
      requires :id, type: Integer, desc: 'Note ID'
    end
    get do
    end
  end

  add_swagger_documentation
end
