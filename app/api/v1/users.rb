# frozen_string_literal: true

module V1
  class Users < Grape::API
    version 'v1', using: :path

    namespace :users do
      desc 'Create new user'
      params do
        requires :username, type: String, documentation: { param_type: 'body' }
      end
      post do
        User.create!(declared(params))
      end
    end
  end
end
