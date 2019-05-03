module V1
  class NotesController < ApplicationController
    def index
      @notes = current_user.notes.order("created_at DESC")
      json_response(@notes)
    end

    def show
      @note = current_user.notes.find(params[:id])
      json_response(@note)
    end

    def create
      @note = current_user.notes.create!(note_params)
      json_response(@note, :created)
    end

    def update
      @note = current_user.notes.find(params[:id])
      @note.update(note_params)
      head :no_content
    end

    def destroy
      @note = current_user.notes.find(params[:id])
      @note.destroy
      head :no_content
    end

    private

    def note_params
      params.permit(:note, :created_by, :user_id)
    end
  end
end
