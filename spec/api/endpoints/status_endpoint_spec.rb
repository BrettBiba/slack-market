require 'spec_helper'

describe Api::Endpoints::StatusEndpoint, vcr: { cassette_name: 'iex/msft' } do
  include Api::Test::EndpointTest

  before do
    allow_any_instance_of(Team).to receive(:ping!).and_return(ok: 1)
  end

  context 'status' do
    it 'returns a status' do
      status = client.status
      expect(status.teams_count).to eq 0
      expect(status.msft['symbol']).to eq 'MSFT'
    end

    context 'with a team' do
      let!(:team) { Fabricate(:team, active: false) }
      it 'returns a status with ping' do
        status = client.status
        expect(status.teams_count).to eq 1
        ping = status.ping
        expect(ping['ok']).to eq 1
      end
    end
  end
end
