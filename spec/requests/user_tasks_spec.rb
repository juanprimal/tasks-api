require 'rails_helper'

RSpec.describe 'UserTasks API' do
  let!(:user) { create(:user) }
  let!(:user_tasks) { create_list(:user_task, 10, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { user_tasks.first.id }

  # Test suite for GET /users/:user_id/user_tasks
  describe 'GET /users/:user_id/user_tasks' do
    before { get "/users/#{user_id}/user_tasks" }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user user_tasks' do
        json = JSON.parse(response.body)
        expect(json.size).to eq(10)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a could not find message' do
        expect(response.body).to match(/Couldn't find User with 'id'=100/)
      end
    end
  end

  # Test suite for GET /users/:user_id/user_tasks/:id
  describe 'GET /users/:user_id/user_tasks/:id' do
    before { get "/users/#{user_id}/user_tasks/#{id}" }

    context 'when user user_task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user_task' do
        json = JSON.parse(response.body)
        expect(json['id']).to eq(id)
      end
    end

    context 'when user user_task does not exist' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a could not find message' do
        expect(response.body).to include("Couldn't find UserTask")
      end
    end
  end

  # Test suite for PUT /users/:user_id/user_tasks
  describe 'POST /users/:user_id/user_tasks' do
    let(:valid_attributes) { { description: 'Visit Narnia', state: false } }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/user_tasks", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/user_tasks", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/user_tasks/:id
  describe 'PUT /users/:user_id/user_tasks/:id' do
    let(:valid_attributes) { { description: 'Mozart' } }

    before { put "/users/#{user_id}/user_tasks/#{id}", params: valid_attributes }

    context 'when user_task exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the user_task' do
        updated_user_task = UserTask.find(id)
        expect(updated_user_task.description).to match(/Mozart/)
      end
    end

    context 'when the user_task does not exists' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a could not find message' do
        expect(response.body).to match(/Couldn't find UserTask/)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}/user_tasks/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end