require 'spec_helper'
describe 'foobar' do
  context 'with default values for all parameters' do
    it { should contain_class('foobar') }
  end
end
