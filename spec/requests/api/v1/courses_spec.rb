# frozen_string_literal: true

require 'swagger_helper'

item_schema = {
  type: :object,
  properties: {
    id:         { type: :string, format: :uuid },
    name:       { type: :string },
    created_at: { type: :string },
    author: { type: :object,
              properties: {
                id:         { type: :string, format: :uuid },
                name:       { type: :string },
                created_at: { type: :string } } },
    competences: { type: :array,
                   items: { type: :object,
                            properties: {
                              id:         { type: :string, format: :uuid },
                              name:       { type: :string },
                              created_at: { type: :string } } } },
  },
  required: %i(id name created_at author competences)
}

describe 'Authors API', type: :request, swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/courses' do
    get 'Retrieves an courses' do
      produces 'application/json'
      response '200', 'successful request' do
        schema type: :array,
               items: item_schema,
               required: %i(id name created_at author competences)

        run_test!
      end
    end
  end

  path '/api/v1/courses/{id}' do
    get 'Retrieves one course' do
      produces 'application/json'
      parameter name: :id, in: :path, type: :id, description: 'UUID', format: 'uuid'
      response '200', 'successful request' do
        schema item_schema

        let(:id) { Course.create(name: 'foo', author: Author.first).id }

        run_test!
      end

      response '404', 'not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end

  path '/api/v1/courses' do
    post 'Create one course' do
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: 'name', in: :formData, type: :string
      parameter name: 'author_id', in: :formData, type: :string
      parameter name: 'course_competences_attributes[]', in: :formData, explode: true, schema: { type: :array, items: { type: :string } }

      let('course_competences_attributes[]') { [Competence.first.id, Competence.second.id] }

      response '201', 'successful request' do
        schema item_schema

        let(:name) { 'test' }
        let(:author_id) { Author.first.id }

        run_test!
      end

      response '500', 'error with empty name' do
        let(:name) { '' }
        let(:author_id) { Author.first.id }

        run_test!
      end

      response '500', 'error with empty author' do
        let(:name) { 'test' }
        let(:author_id) { '' }

        run_test!
      end
    end
  end

  path '/api/v1/courses/{id}' do
    patch 'Update one course' do
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'UUID'
      parameter name: 'name', in: :formData, type: :string
      parameter name: 'author_id', in: :formData, type: :string
      parameter name: 'course_competences_attributes[]', in: :formData, explode: true, schema: { type: :array, items: { type: :string } }

      let(:id) { Course.create(name: 'foo', author: Author.first).id }
      let('course_competences_attributes[]') { [Competence.first.id, Competence.second.id] }

      response '200', 'successful request' do
        schema item_schema

        let(:name) { 'test' }
        let(:author_id) { Author.first.id }

        run_test!
      end

      response '200', 'successful request without competences' do
        schema item_schema

        let(:name) { 'test' }
        let(:author_id) { Author.first.id }
        let('course_competences_attributes[]') { nil }

        run_test!
      end

      response '500', 'error with empty name' do
        let(:name) { '' }
        let(:author_id) { Author.first.id }

        run_test!
      end

      response '500', 'error with empty author' do
        let(:name) { 'test' }
        let(:author_id) { '' }

        run_test!
      end
    end
  end

  path '/api/v1/courses/{id}' do
    delete 'Destroy one course' do
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'UUID'

      response '200', 'successful request' do
        schema item_schema

        let(:id) { Course.create(name: 'foo', author: Author.first).id }

        run_test!
      end

      response '404', 'not found' do
        let(:id) { '' }

        run_test!
      end
    end
  end
end
