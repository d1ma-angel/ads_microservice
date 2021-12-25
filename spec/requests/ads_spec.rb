RSpec.describe 'Ads API', type: :routes do
  describe 'GET /' do
    before { create_list(:ad, 3) }

    it 'returns a collection of ads' do
      get '/'

      expect(last_response.status).to eq(200)
      expect(response_body['data'].size).to eq(3)
    end
  end

  describe 'POST / (valid auth token)' do
    let(:user_id) { 123 }
    let(:auth_token) { 'auth.token' }
    let(:auth_service) { instance_double('Auth service') }
    let(:city) { 'City' }
    let(:coordinates) { [64.5625385, 39.8180934] }
    let(:geocoder_service) { instance_double('Geocoder service') }

    before do
      allow(auth_service).to receive(:auth)
        .with(auth_token)
        .and_return(user_id)

      allow(AuthService::Client).to receive(:new)
        .and_return(auth_service)

      allow(geocoder_service).to receive(:geocode)
        .with(city)
        .and_return(coordinates)

      allow(GeocoderService::Client).to receive(:new)
        .and_return(geocoder_service)

      header 'Authorization', "Bearer #{auth_token}"
    end

    context 'missing parameters' do
      it 'returns an error' do
        post '/'

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: ''
        }
      end
      let(:city) { nil }

      it 'returns an error' do
        post '/', ad: ad_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Укажите город',
            'source' => {
              'pointer' => '/data/attributes/city'
            }
          }
        )
      end
    end

    context 'empty user_id' do
      let(:user_id) { nil }
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      it 'returns an error' do
        post '/', ad: ad_params

        expect(last_response.status).to eq(403)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Доступ к ресурсу ограничен'
          }
        )
      end
    end

    context 'valid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      let(:last_ad) { ::Ad.last }

      it 'creates a new ad' do
        expect { post '/', ad: ad_params }
          .to change { ::Ad.count }.from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an ad' do
        post '/', ad: ad_params

        expect(response_body['data']).to a_hash_including(
          'id' => last_ad.id.to_s,
          'type' => 'ad'
        )
      end
    end
  end
end
