require 'rails_helper'

describe 'Sessions API' do
  it 'it can login a user' do
    User.create!({ email: "email@email.com",
                   password: "abc123",
                   password_confirmation: "abc123",
                   api_key: 'I-AM-A-API-KEY'})


    headers = {'CONTENT_TYPE' => 'application/json'}
    json_payload = { email: "email@email.com",
                     password: "abc123"
                    }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(json_payload)
    expect(response).to be_successful
    expect(response.status).to eq(200)
    json = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(json).to_not have_key(:password)
    expect(json[:attributes]).to_not have_key(:password)
    expect(json[:attributes][:api_key]).to be_a(String)
    expect(json[:attributes][:api_key]).to eq('I-AM-A-API-KEY')
  end

  it 'returns an error if user is not found' do
    headers = {'CONTENT_TYPE' => 'application/json'}
    json_payload = { email: "email@email.com",
                    password: "abc123",
                    }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(json_payload)
    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:messages]).to include("E-mail or Password are incorrect")
  end

  it 'returns an error if user password is incorrect' do
    User.create!({ email: "email@email.com",
                   password: "abc123",
                   password_confirmation: "abc123",
                   api_key: 'I-AM-A-API-KEY'})

    headers = {'CONTENT_TYPE' => 'application/json'}
    json_payload = { email: "email@email.com",
                     password: "abc321",
                    }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(json_payload)
    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:messages]).to include("E-mail or Password are incorrect")
  end

  it 'returns an error if a field is empty' do
    User.create!({ email: "email@email.com",
                   password: "abc123",
                   password_confirmation: "abc123",
                   api_key: 'I-AM-A-API-KEY'})

    headers = {'CONTENT_TYPE' => 'application/json'}
    json_payload = { email: "",
                     password: "abc123",
                    }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(json_payload)
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:messages]).to include("E-mail or Password information not provided")

      json_payload = { email: "email@email.com",
                     password: "",
                    }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(json_payload)
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:messages]).to include("E-mail or Password information not provided")
  end
end
