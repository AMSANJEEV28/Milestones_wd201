require "date"

class Todo
  def initialize(text, due_date, completed)
    @text = text
    @due_date = due_date
    @status = completed
  end

  # returns true if todo is overdue
  def overdue?
    @due_date < Date.today
  end

  # returns true if due is today
  def due_today?
    @due_date == Date.today
  end

  # returns true if due is later
  def due_later?
    @due_date > Date.today
  end

  # retuns formatted string with checkboxes
  def to_displayable_string
    checkbox = @status ? "[X]" : "[ ]"
    disp_date = due_today? ? nil : @due_date
    "#{checkbox} #{@text} #{disp_date}"
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  # adds new todos from the Todo class
  def add(todo)
    @todos.push(todo)
  end

  # filters the overdue todos
  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  # filters the today's todos
  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  # filters the future todos
  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  # Returns a fornatted list with checkboxes
  def to_displayable_list
    displayable_list = @todos.map { |todo| todo.to_displayable_string }.join("\n")
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"