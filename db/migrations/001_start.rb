Sequel.migration do
  change do
    create_table(:book) do
      String :uuid, :size=>255, :null=>false
      String :title, :size=>255
      String :author, :size=>255
      String :language, :size=>255
      DateTime :createtime
      Integer :id
      
      primary_key [:uuid]
    end
    
    create_table(:category) do
      Integer :id, :null=>false
      String :iconcolor, :size=>6
      String :iconurl, :size=>255
      String :name, :size=>255
      String :description, :size=>255
      Integer :parent_id
      Integer :listorder
    end
    
    create_table(:category_book) do
      Integer :categories_id
      Integer :books_id
    end
    
    create_table(:log, :ignore_index_errors=>true) do
      Bignum :id, :null=>false
      String :client_id, :size=>1024
      String :session_id, :size=>1024
      String :user_id, :size=>1024
      String :country, :size=>1024
      String :user_agent, :size=>1024
      String :url, :size=>1024
      String :book_id, :size=>1024
      DateTime :created_at
      
      primary_key [:id]
      
      index [:book_id], :name=>:book_id
      index [:user_id], :name=>:user_id
    end
    
    create_table(:wr_user) do
      String :id, :size=>256, :null=>false
      Bignum :usergender
      Bignum :age
      DateTime :createdat
      DateTime :updatedat
      
      primary_key [:id]
    end
  end
end
