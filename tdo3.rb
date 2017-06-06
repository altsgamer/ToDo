class TodoList
	attr_reader :list

	def self.load(file)
		# read the file, create a list, create items, add them to the list, return the list
		list = TodoList.new
		File.read(file).each_line do |line|
			list.add line
		end

		list
	end

	def initialize
		@list = []
	end

	def add(todo)
		@list << TodoItem.new(todo.rstrip)
	end
	
	def done(id)
		@list[id.to_i].done = true
	end

	def write(file)
		content = ""
		# Reject thing DOESNT work, it just returns the object
		#// @list.each do |item|
		#// 	content += item.name + "\n" unless item.done
		#// end

		# write the file, only write the undone items
		File.open(file, 'w') do |f|
			f.write(@list.reject {|item| item.done}.join("\n"))
		end
	end

	def [](id)
		@list[id]
	end
end

class TodoItem
	# provide reader and setter for name and state
	attr_accessor :name, :done

	def initialize(name)
		# store name
		# set state to undone
		@name = name
		@done = false
	end

	def to_s
		@name	
	end
end

class CommandLineInterface
	def initialize
		@list = TodoList.load("todo.td")	
	end

	def done
		@list.done ARGV[1]
	end

	def add
		@list.add ARGV[1]
	end

	def write
		@list.write("todo.td")
	end

	def list
		@list.list.each_with_index do |line, index|
			puts "##{index} - #{line.name.capitalize}"
		end
	end
end

# ---
# the library will be used like this:
# list = TodoList.load("todo.td")
# list[0].done = true
# list.add TodoItem.new("another cool item")
# list.write("todo.td")
#

cli = CommandLineInterface.new
cli.send ARGV[0]
cli.write