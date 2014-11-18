describe Activerecord::Mysql::Pkdump do
  context 'when there is no table' do
    it do
      expect(dump).to eq <<-RUBY.strip
ActiveRecord::Schema.define(version: 0) do

end
      RUBY
    end
  end

  context 'when PK is `id`(int)' do
    before do
      create_tables(:id, 'int(11) primary key auto_increment')
    end

    it do
      expect(dump).to eq <<-RUBY.strip
ActiveRecord::Schema.define(version: 0) do

  create_table "authors", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "title",      null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
      RUBY
    end
  end

  context 'when PK is `my_id`(int)' do
    before do
      create_tables(:my_id, 'int(11) primary key auto_increment')
    end

    it do
      expect(dump).to eq <<-RUBY.strip
ActiveRecord::Schema.define(version: 0) do

  create_table "authors", primary_key: "my_id", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", primary_key: "my_id", force: true do |t|
    t.string   "title",      null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
      RUBY
    end
  end

  context 'when PK is `id`(bigint)' do
    before do
      create_tables(:id, 'bigint primary key auto_increment')
    end

    it do
      expect(dump).to eq <<-RUBY.strip
ActiveRecord::Schema.define(version: 0) do

  create_table "authors", id: "bigint(20) PRIMARY KEY auto_increment", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", id: "bigint(20) PRIMARY KEY auto_increment", force: true do |t|
    t.string   "title",      null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
      RUBY
    end
  end

  context 'when PK is `my_id`(bigint)' do
    before do
      create_tables(:my_id, 'bigint primary key auto_increment')
    end

    it do
      expect(dump).to eq <<-RUBY.strip
ActiveRecord::Schema.define(version: 0) do

  create_table "authors", primary_key: "my_id", id: "bigint(20) PRIMARY KEY auto_increment", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", primary_key: "my_id", id: "bigint(20) PRIMARY KEY auto_increment", force: true do |t|
    t.string   "title",      null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
      RUBY
    end
  end

  context 'when PK is `id`(varchar(255))' do
    before do
      create_tables(:id, 'varchar(255) primary key')
    end

    it do
      expect(dump).to eq <<-RUBY.strip
ActiveRecord::Schema.define(version: 0) do

  create_table "authors", id: "varchar(255) PRIMARY KEY", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", id: "varchar(255) PRIMARY KEY", force: true do |t|
    t.string   "title",      null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
      RUBY
    end
  end

  context 'when PK is `my_id`(varchar(255))' do
    before do
      create_tables(:my_id, 'varchar(255) primary key')
    end

    it do
      expect(dump).to eq <<-RUBY.strip
ActiveRecord::Schema.define(version: 0) do

  create_table "authors", primary_key: "my_id", id: "varchar(255) PRIMARY KEY", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", primary_key: "my_id", id: "varchar(255) PRIMARY KEY", force: true do |t|
    t.string   "title",      null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
      RUBY
    end
  end
end
