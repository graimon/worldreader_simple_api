require 'spec_helper'
require 'wr_api'

RSpec.describe WrApi do

  subject { WrApi }

  def keep_env
    original_env = ENV['APP_ENV']
    yield
  ensure
    ENV['APP_ENV'] = original_env
  end

  describe '.env' do
    it 'returns the current APP_ENV' do
      keep_env do
        ENV['APP_ENV'] = "custom_env"

        expect(subject.env).to eq "custom_env"
      end
    end
  end

end
