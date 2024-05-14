# frozen_string_literal: true

class NotesAPI < Grape::API
  version 'v1', using: :path

  namespace :notes do
    desc 'List user notes'
    get do
      Note.all
    end

    desc 'Create a new note'
    post do
      Note.create!(declared(params))
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
