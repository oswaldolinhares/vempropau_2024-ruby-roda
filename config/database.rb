require 'sequel'

DB = Sequel.connect(adapter: 'postgres', host: 'db', database: 'vempropau', user: 'paulao', password: 'segredosagrado')
