require "date"

class Todo
def initialize(new_todo, due_date, completed)
    @task = new_todo
    @due_date = due_date
    @completed = completed

    if @completed == true
      @checkbox = "[ ]"
    else
      @checkbox = "[X]"
    end
  end

  def overdue?
    # todo=>overdue

    if @due_date < Date.today
      return true
    else
      return false
    end
  end

  def due_today?
    # todo=>today.

    if @due_date == Date.today
      return true
    else
      return false
    end
  end

  def due_later?
    #todo=>later.

    if @due_date > Date.today
      return true
    else
      return false
    end
  end


  def to_displayable_string
    
    if @due_date == Date.today
      string_todo = "#{@checkbox} #{@task}"
    else
      string_todo = "#{@checkbox} #{@task} #{@due_date}"
    end

    return string_todo
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end  

  def add(new_todo)
   @todos.append(new_todo)
  end

  def due_today
    # list of todos ==> due today.
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  def due_later
    # list of todos ==> due later.
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  def to_displayable_list
@todos.map { |todo| todo.to_displayable_string }
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
