require 'rack/test'
require 'spec_helper'

RSpec.describe "books" do
  include Rack::Test::Methods
  
  def create_book
    data = {
      :uuid       => Faker::Crypto.sha256, 
      :id         => Faker::Number.number(2).to_i, 
      :title      => Faker::Book.unique.title, 
      :author     => Faker::Book.unique.author, 
      :language   => "Spanish", 
      :createtime => Faker::Date.backward(14)
    }
    uuid = WrApi::Models::Book.table.insert data
    WrApi::Models::Book.get uuid
  end

  def app
    WrApi::Api::V1::Books
  end

  let!(:book_1) { create_book }
  let!(:book_2) { create_book }
  let!(:book_3) { create_book }

  let(:page)      { 1 }
  let(:per_page)  { 2 }

  let(:params) do
    { :page => page, :per_page => per_page }
  end

  it 'returns a serialized list of books' do
    get "/api/v1/books.json", params

    expect(last_response.status).to eq 200
    response = JSON.parse(last_response.body)

    newer_two = [book_1.uuid, book_2.uuid]

    expect(response['books'].map{|book| book['uuid']}).to eq newer_two

    expect(response['page']).to eq page
    expect(response['per_page']).to eq per_page
    expect(response['total_pages']).to eq 2
    expect(response['total_results']).to eq 3
  end

  it 'returns a serialized book' do
    get "/api/v1/books/#{book_1.uuid}.json"

    expect(last_response.status).to eq 200
    response = JSON.parse(last_response.body)

    expect(response['uuid']).to eq book_1.uuid
    expect(response['id']).to eq book_1.id
    expect(response['title']).to eq book_1.title
    expect(response['author']).to eq book_1.author
  end

end
