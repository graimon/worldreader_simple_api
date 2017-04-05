require 'rack/test'
require 'spec_helper'

RSpec.describe "categories" do
  include Rack::Test::Methods
  
  def create_category
    data = {
      :id           => Faker::Number.unique.number(2).to_i, 
      :iconcolor    => Faker::Color.hex_color[1..-1], 
      :iconurl      => Faker::LoremPixel.image, 
      :name         => Faker::Lorem.word, 
      :description  => Faker::Lorem.sentence, 
      :parent_id    => Faker::Number.number(2).to_i, 
      :listorder    => Faker::Number.number(2).to_i
    }
    WrApi::Models::Category.table.insert data
    WrApi::Models::Category.get data[:id]
  end

  def app
    WrApi::Api::V1::Categories
  end

  let!(:category_1) { create_category }
  let!(:category_2) { create_category }
  let!(:category_3) { create_category }

  let(:page)      { 1 }
  let(:per_page)  { 2 }

  let(:params) do
    { :page => page, :per_page => per_page }
  end

  it 'returns a serialized list of categories' do
    get "/api/v1/categories.json", params

    expect(last_response.status).to eq 200
    response = JSON.parse(last_response.body)

    newer_two = [category_1, category_2, category_3].sort do |a, b| 
      a.listorder <=> b.listorder
    end.first(2).map(&:id)

    expect(response['categories'].map{|category| category['id']}).to eq newer_two

    expect(response['page']).to eq page
    expect(response['per_page']).to eq per_page
    expect(response['total_pages']).to eq 2
    expect(response['total_results']).to eq 3
  end

  it 'returns a serialized category' do
    get "/api/v1/categories/#{category_1.id}.json"

    expect(last_response.status).to eq 200
    response = JSON.parse(last_response.body)

    expect(response['id']).to eq category_1.id
    expect(response['iconcolor']).to eq category_1.iconcolor
    expect(response['name']).to eq category_1.name
    expect(response['description']).to eq category_1.description
  end
  
  context "books in a category" do

    def create_book_in_category category_id
      data = {
        :uuid       => Faker::Crypto.sha256, 
        :id         => Faker::Number.number(2).to_i, 
        :title      => Faker::Book.unique.title, 
        :author     => Faker::Book.unique.author, 
        :language   => "Spanish", 
        :createtime => Faker::Date.backward(14)
      }
      uuid = WrApi::Models::Book.table.insert data
      book = WrApi::Models::Book.get uuid
      DB[:category_book].insert :books_id => book.id, :categories_id => category_id
      book
    end
    
    let!(:book_1) { create_book_in_category category_1.id }
    let!(:book_2) { create_book_in_category category_1.id }
    let!(:book_3) { create_book_in_category category_1.id  }
  
    it 'returns a serialized list of books from a category' do
      get "/api/v1/categories/#{category_1.id}/books.json", params

      expect(last_response.status).to eq 200
      response = JSON.parse(last_response.body)

      newer_two = [book_1.uuid, book_2.uuid]

      expect(response['books'].map{|book| book['uuid']}).to eq newer_two

      expect(response['page']).to eq page
      expect(response['per_page']).to eq per_page
      expect(response['total_pages']).to eq 2
      expect(response['total_results']).to eq 3
    end

  end
end