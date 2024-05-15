# frozen_string_literal: true

module V1
  class Notes < Grape::API
    version 'v1', using: :path

    helpers do
      def current_user
        return @current_user if defined?(@current_user)

        username = env['HTTP_AUTHORIZATION'].split.last
        @current_user = User.where(username: username).first
      end
    end

    namespace :notes do
      before do
        error!('Unauthorized', 401) unless current_user
      end

      desc 'List user notes'
      get do
        Note.where(user: current_user)
      end

      desc 'Create a new note'
      params do
        requires :content, type: String, documentation: { param_type: 'body' }
      end
      post do
        Note.create!(declared(params).merge(user: current_user))
      end

      params do
        requires :id, type: Integer, desc: 'Note ID'
      end
      route_param :id do
        desc 'Get a specific note'
        get do
          Note.find(params[:id])
        end

        desc 'Update a note'
        put do
          note = Note.find(params[:id])
          note.update!(declared(params))
        end

        desc 'Delete a note'
        delete do
          Note.find(params[:id]).destroy!
        end
      end
    end
  end
end
