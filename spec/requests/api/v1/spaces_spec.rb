require 'spec_helper'

describe 'GET /v1/users/:id/spaces/:id' do
  it 'returns a space by :id' do
    space = create(:space)

    get "/v1/users/#{space.user_id}/spaces/#{space.id}"

    expect(response_json).to eq(
      {
        'width'         => space.width,
        'length'        => space.length,

        'created_at'    => space.created_at.as_json,
        'updated_at'    => space.updated_at.as_json,

        'user_id'       => space.user_id
      }
    )
  end
end

describe 'GET /v1/users/:id/spaces' do
  it 'retrives all spaces' do
    space_1 = create(:space)
    space_2 = create(:space)

    get '/v1/users/:id/spaces', {}

    expect(response_json.first.last).to eq([
      {
        'id'            => space_1.id,

        'created_at'    => space_1.created_at.as_json,
        'updated_at'    => space_1.updated_at.as_json,

        'user_id'       => space_1.user_id
      },
      {
        'id'            => space_2.id,

        'created_at'    => space_2.created_at.as_json,
        'updated_at'    => space_2.updated_at.as_json,

        'user_id'       => space_2.user_id
      }
    ])
  end
end

describe 'POST /v1/users/:id/spaces' do
  it 'saves a space' do
    space = create(:space)

    post '/v1/users/:id/spaces', {}.to_json

    space = Space.last
    expect(response_json).to eq(
      {
        'id'            => space.id
       }
    )
  end
end

describe 'PATCH /v1/users/:id/spaces/:id' do
  it "updates the space's creation date" do
    space = create(:space)
    new_created_at = Time.zone.now - 86400  # one day ago

    patch "/v1/users/:id/spaces/#{space.id}", {
      created_at: new_created_at
    }

    space = space.reload
    expect(space.created_at.to_i).to eq new_created_at.to_i
    expect(response_json).to eq({ 'id' => space.id })
  end
end

describe 'DELETE /v1/users/:id/spaces/:id' do
  it "deletes a space by :id" do
    space = create(:space)

    delete "/v1/users/:id/spaces/#{space.id}", {}

    expect(Space.count).to eq 0
    expect(response_json).to eq({ 'id' => space.id })
  end
end
