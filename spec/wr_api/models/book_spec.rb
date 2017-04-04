require 'spec_helper'

RSpec.describe WrApi::Models::Book do
  
  let(:uuid)        { Faker::Crypto.sha256 }
  let(:id)          { Faker::Number.digit.to_i }
  let(:title)       { Faker::Book.title }
  let(:author)      { Faker::Book.author }
  let(:language)    { "Spanish" }
  let(:createtime)  { Faker::Date.backward(14) }
  
  let(:data) do 
    {
      :uuid       => uuid, 
      :id         => id, 
      :title      => title, 
      :author     => author, 
      :language   => language, 
      :createtime => createtime
    }
  end
  
  describe ".initialize" do
  
    subject { described_class.new data }
    
    it do
      expect(subject.uuid).to       eq uuid
      expect(subject.id).to         eq id
      expect(subject.title).to      eq title
      expect(subject.author).to     eq author
      expect(subject.language).to   eq language
      expect(subject.createtime).to eq createtime
    end
    
  end
  
  describe "self.get" do
    
    before do
      described_class.table.insert data
    end
    
    subject { described_class.get uuid }
    
    it do
      expect(subject.uuid).to  eq uuid
      expect(subject.id).to    eq id
      expect(subject.title).to eq title
      #...
    end
    
  end
  
  
end