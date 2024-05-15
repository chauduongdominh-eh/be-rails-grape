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

      def authenticate!
        error!('Unauthorized', 401) unless current_user
      end
    end

    namespace :notes do
      before do
        authenticate!
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
        helpers do
          def current_record
            return @current_record if defined?(@current_record)

            @current_record = Note.where(id: params[:id], user: current_user).first
          end
        end

        desc 'Get a specific note'
        get do
          current_record
        end

        desc 'Update a note'
        params do
          requires :content, type: String, allow_blank: false, desc: 'Note content'
        end
        put do
          current_record.update!(declared(params))
          current_record
        end

        desc 'Delete a note'
        delete do
          current_record.destroy!
          status 204
        end
      end
    end
  end
end
