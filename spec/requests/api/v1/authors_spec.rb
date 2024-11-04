# frozen_string_literal: true

require 'swagger_helper'

describe 'Authors API', type: :request, swagger_doc: 'v1/swagger.yaml' do
  item_schema = {
    type: :object,
    properties: {
      id:         { type: :string, format: :uuid },
      name:       { type: :string },
      created_at: { type: :string }
    },
    required: %i(id name created_at)
  }

  path '/api/v1/authors' do
    get 'Retrieves a authors' do
      produces 'application/json'
      response '200', 'successful request' do
        schema type: :array,
               items: item_schema,
               required: %i(id name created_at)

        run_test!
      end
    end
  end

  path '/api/v1/authors/{id}' do
    get 'Retrieves one author' do
      produces 'application/json'
      parameter name: :id, in: :path, type: :id, description: 'UUID', format: 'uuid'
      response '200', 'successful request' do
        schema item_schema

        let(:id) { Author.create(name: 'foo').id }

        run_test!
      end

      response '404', 'not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end

  path '/api/v1/authors' do
    post 'Create one author' do
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: 'name', in: :formData, type: :string

      response '201', 'successful request' do
        schema item_schema

        let(:name) { 'test' }

        run_test!
      end

      response '500', 'error with empty name' do
        let(:name) { '' }

        run_test!
      end
    end
  end

  path '/api/v1/authors/{id}' do
    patch 'Update one author' do
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'UUID'
      parameter name: 'name', in: :formData, type: :string

      let(:id) { Author.create(name: 'foo').id }

      response '200', 'successful request' do
        schema item_schema

        let(:name) { 'test' }

        run_test!
      end

      response '500', 'error with empty name' do
        let(:name) { '' }
        run_test!
      end
    end
  end

  path '/api/v1/authors/{id}' do
    delete 'Destroy one author' do
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'UUID'

      response '200', 'successful request' do
        schema type: :object,
               properties: {
                 status: { type: :string },
               },
               required: %i(status)

        let(:id) { Author.create(name: 'foo').id }

        run_test!
      end

      response '404', 'not found' do
        let(:id) { '' }

        run_test!
      end
    end
  end
end
