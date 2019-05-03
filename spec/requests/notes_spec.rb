require 'rails_helper'

RSpec.describe 'Notes API', type: :request do
  # add note owner
  let(:user)     { create(:user) }
  let!(:notes)   { create_list(:note, 10, created_by: user.name, user_id: user.id) }
  let(:note_id)  { notes.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /Notes
  describe 'GET /notes' do
    # make HTTP get request before each example
    before { get '/notes', params: {}, headers: headers }

    it 'returns notes' do
      expect(json).not_to be_empty
      expect(json.size).to eql(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  # Test suite for GET /notes/:id
  describe 'GET /notes/:id' do
    # make HTTP get request before each example
    before { get "/notes/#{note_id}", params: {}, headers: headers }

    context 'when record exists' do
      it 'returns the note' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(note_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let(:note_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Note with 'id'=#{note_id}/)
      end
    end
  end

  # Test suite for POST /notes
  describe 'POST /notes' do
    # valid payload
    let(:valid_attributes) do
      { note: 'Hi KG', created_by: user.name, user_id: user.id }.to_json
    end

    context 'when the request is valid' do
      before { post '/notes', params: valid_attributes, headers: headers }

      it 'creates a note' do
        
        expect(json['note']).to eq('Hi KG')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { note: nil }.to_json }
      before { post '/notes', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Note can't be blank/)
      end
    end

    # Test suite for PUT /notes/:id
    describe 'PUT /notes/:id' do
      let(:valid_attributes) { { note: 'Shopping' }.to_json }

      context 'when record exists' do
        before { put "/notes/#{note_id}", params: valid_attributes, headers: headers }

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end

        it 'updates the record' do
          expect(response.body).to be_empty
        end
      end
    end
  end

  # Test suite for DELETE /notes/:id
  describe 'DELETE /notes/:id' do
    before { delete "/notes/#{note_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
