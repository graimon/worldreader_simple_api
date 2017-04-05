require 'spec_helper'

RSpec.describe WrApi::Models::Category do
  
  let(:category_id) { Faker::Number.number(2).to_i }
  let(:iconcolor)   { Faker::Color.hex_color[1..-1] }
  let(:iconurl)     { Faker::LoremPixel.image }
  let(:name)        { Faker::Lorem.word }
  let(:description) { Faker::Lorem.sentence }
  let(:parent_id)   { Faker::Number.number(2).to_i }
  let(:listorder)   { Faker::Number.number(2).to_i }
  
  let(:data) do 
    {
      :id           => category_id, 
      :iconcolor    => iconcolor, 
      :iconurl      => iconurl, 
      :name         => name, 
      :description  => description, 
      :parent_id    => parent_id, 
      :listorder    => listorder
    }
  end
  
  describe ".initialize" do
  
    subject { described_class.new data }
    
    it do
      expect(subject.id).to           eq category_id
      expect(subject.iconcolor).to    eq iconcolor
      expect(subject.iconurl).to      eq iconurl
      expect(subject.name).to         eq name
      expect(subject.description).to  eq description
      expect(subject.parent_id).to    eq parent_id
      expect(subject.listorder).to    eq listorder
    end
    
  end
  
  context "with data" do
  
    before do
      described_class.table.insert data
    end
    
    subject { described_class.get category_id }
    
    describe "self.get" do
    
      it do
        expect(subject.id).to           eq category_id
        expect(subject.iconcolor).to    eq iconcolor
        expect(subject.iconurl).to      eq iconurl
        #...
      end
    
    end
  
    describe ".books" do
  
      let(:uuid1)       { Faker::Crypto.sha256 }
      let(:uuid2)       { Faker::Crypto.sha256 }
      let(:book_id1)    { Faker::Number.unique.number(2).to_i }
      let(:book_id2)    { Faker::Number.unique.number(2).to_i }
      let(:title)       { Faker::Book.title }
      let(:author)      { Faker::Book.author }
      let(:language)    { "Spanish" }
      let(:createtime)  { Faker::Date.backward(14) }
  
      let(:book1) do 
        {
          :uuid       => uuid1, 
          :id         => book_id1, 
          :title      => title, 
          :author     => author, 
          :language   => language, 
          :createtime => createtime
        }
      end
      
      let(:book2) do 
        {
          :uuid       => uuid2, 
          :id         => book_id2, 
          :title      => title, 
          :author     => author, 
          :language   => language, 
          :createtime => createtime
        }
      end
      
      before do
        DB[:book].insert book1
        DB[:book].insert book2
        DB[:category_book].insert :books_id => book_id1, :categories_id => category_id
        DB[:category_book].insert :books_id => book_id2, :categories_id => category_id
      end
      
      it do
        stored_book1 = WrApi::Models::Book.get uuid1
        stored_book2 = WrApi::Models::Book.get uuid2
        
        category_books = subject.books 0, 20
        
        expect(category_books.map(&:uuid)).to eq [stored_book1.uuid, stored_book2.uuid]
        expect(category_books.map(&:id)).to eq [stored_book1.id, stored_book2.id]
        expect(category_books.map(&:title)).to eq [stored_book1.title, stored_book2.title]
      end
    
    end
  
  end
  
  
end