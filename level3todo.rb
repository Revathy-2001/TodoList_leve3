require "date"

class Todo
  def initialize(text, due_date, completed)
    @text = text
    @due_date = due_date
    @completed = completed
  end

  def overdue?
    overdue = (@due_date < Date.today) ? true : false
  end

  def due_date?
    duedate = (@due_date == Date.today) ? true : false
  end

  def due_later?
    duelater = (@due_date > Date.today) ? true : false
  end

  def to_displayable_string
    line = ""
    if (@due_date == Date.today - 1)
      line = (@completed) ? line += "[ ] #{@text} #{@due_date}" : line += "[ ] #{@text} #{@due_date}"
    elsif (@due_date == Date.today)
      line = (@completed) ? "[X] #{@text}" : "[ ] #{@text}"
    else
      line += "[ ] #{@text} #{@due_date}"
    end
  end
end

class TodosList
  # attr_accessor :todos

  def initialize(todos)
    @todos = todos
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_date? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  def add(new_element)
    @todos << new_element
  end

  def to_displayable_list
    arr = []
    @todos.each { |obj| arr << obj.to_displayable_string }
    print arr.join("\n")
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
