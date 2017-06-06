class Todo
  def initialize(*argv)
    @argv = argv

    begin
      send(@argv[0])
    rescue TypeError
      list
    rescue NoMethodError
      puts "Command #{@argv[0]} not found.\n\n"
      help
    end
  end

  # Lists help information
  def help
    puts <<-help
Commands for Todo.rb:
   add [task name] - Add a new task
   list - Lists all tasks
   done [task id] - Complete a task
   help - Prints out this information
    help
  end

  # Add task
  def add
    unless @argv[1]
      puts "Lacking argument [name]"
      exit
    end

    # Append task to file
    contents = File.read('todo.td')

    File.open('todo.td', 'w') do |f|
      todo = contents + @argv[1] + "\n"
      f.write(todo)
    end
  end

  # List all tasks
  def list
    # Read content
    contents = File.read('todo.td')
    puts "No tasks" unless contents

    # Show it with ids
    i = 0
    contents.each_line do |todo|
      i += 1
      puts "##{i} - #{todo}"
    end
  end

  # Finished a task
  def done
    unless @argv[1]
      puts "Lacking argument [id]"
      exit
    end

    # Put tasks into an array
    todos = File.read('todo.td').split("\n")

    unless todos
      puts "No tasks"
      exit
    end

    puts "Completed task: " + todos[@argv[1].to_i - 1]

    # Delete task from array and make string
    todos.delete_at(@argv[1].to_i - 1)
    content = todos.join("\n")

    # Update file
    File.open('todo.td', 'w') do |f|
      f.write(content)
    end
  end
end

todo = Todo.new(*ARGV)