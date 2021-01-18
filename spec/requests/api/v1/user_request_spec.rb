require 'rails_helper'

describe 'User API' do
  it 'it can create a user' do
    headers = {'CONTENT_TYPE' => 'application/json'}
    json_payload = { email: "email@email.com",
                    password: "abc123",
                    password_confirmation: "abc123" }
    post '/api/v1/users', headers: headers, params: JSON.generate(json_payload)
    expect(response).to be_successful
    expect(response.status).to eq(201)
    json = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(json).to_not have_key(:password)
    expect(json[:attributes]).to_not have_key(:password)
    expect(json[:attributes][:api_key]).to be_a(String)
    expect(json[:attributes][:api_key].length).to eq(20)
    user = User.last
    expect(user.password_digest).to_not eq('abc123')
  end

  it 'returns an error if user creation fails' do
    headers = {'CONTENT_TYPE' => 'application/json'}
    json_payload = { email: "email@email.com",
                    password: "abc123",
                    password_confirmation: "abc321" }
    post '/api/v1/users', headers: headers, params: JSON.generate(json_payload)
    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:messages]).to eq("Password confirmation doesn't match Password")
  end
end
