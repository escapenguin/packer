require_relative 'spec_helper'

describe 'windows box' do
  it 'should have a builder-admin user' do
    expect(user 'builder-admin').to exist
  end
end
