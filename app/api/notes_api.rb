# frozen_string_literal: true

class NotesAPI < Grape::API
  version 'v1', using: :path

  namespace :notes do
    desc 'List user notes' do
      tags ['Notes']
    end
    get do
      Note.all
    end

    desc 'Create a new note' do
      tags ['Notes']
    end

    post do
      Note.create!(declared(params))
    end

    params do
      requires :id, type: Integer, desc: 'Note ID'
    end
    route_param :id do
      desc 'Get a specific note' do
        tags ['Notes']
      end
      get do
        Note.find(params[:id])
      end

      desc 'Update a note' do
        tags ['Notes']
      end
      put do
        note = Note.find(params[:id])
        note.update!(declared(params))
      end

      desc 'Delete a note' do
        tags ['Notes']
      end
      delete do
        Note.find(params[:id]).destroy!
      end
    end
  end
end
