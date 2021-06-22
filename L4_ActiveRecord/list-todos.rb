require "./connect_db.rb"
require "./todo.rb"
connect_db!

Todo.show_list