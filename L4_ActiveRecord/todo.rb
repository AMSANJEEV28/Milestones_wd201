require "active_record"

class Todo < ActiveRecord::Base

  #returns boolean of whether today's date is the due date
  def due_today?
    due_date == Date.today
  end

  #filters overdue todos
  def self.overdue
    where("due_date < ?", Date.today)
  end

  #filters today's todos
  def self.due_today
    where("due_date = ?", Date.today)
  end

  #filters the due later todos
  def self.due_later
    where("due_date > ?", Date.today)
  end

  # returns formatted strings for display
  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  # displays a formatted todo list
  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }.join("\n")
  end

  # adds new task
  def self.add_task(new_todo)
    Todo.create!(todo_text: new_todo[:todo_text], due_date: Date.today + new_todo[:due_in_days], completed: false)
  end

  # sets status to true
  def self.mark_as_complete!(todo_id)
    todo = find_by_id(todo_id)

    # for Invalid ID
    if (todo.nil?)
      puts "Sorry,id was not found"
      exit
    end
    # changes :completed to true
    if (!todo[:completed])
      todo[:completed] = true
      todo.save
    end
    todo
  end

  