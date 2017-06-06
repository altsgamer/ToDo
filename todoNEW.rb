require 'csv'

class TodoList

	def initialize
		unless File.file?('todolist.csv')
			File.new('todolist.csv', 'w')
		end
		@todo_array = CSV.read('todolist.csv')
	end

	def list
		@todo_array.each{|elem| p elem}
	end

	def read(n)
	end

	def complete
		write
	end

	def delete
		write
	end

	def new
		write
	end

	def update
		write
	end

	def write
		CSV.open('todolist.csv', 'wb') do |csv|
			@todo_array.each do |a|
				csv << a
			end
		end
	end
end

class TodoItem < Array
	attr_accessor :number, :name, :done
	def initialize(number, name)
		@number = number
		@name = name
		@done = false
	end
end

class CLI #CommandLineInterface
	
	def initialize(*arg)
	    @arg = arg
	    td = TodoList.new
		case @arg[0]
			when ('-h' || '--help')
				help
			when ('-l' || '--list')
				td.list
			when ('-r' || '--read')
				td.read(num)
			when ('-c' || '--complete')
				td.complete(num)
			when ('-d' || '--delete')
				td.delete(num)
			when ('-n' || '--new')
				td.newl(text)
			when ('-u' || '--update')
				td.update(num, text)
		else 
			puts "! Unknown command!"
		help
		end
	end

	def help
		puts 'Commands for todo.rb:'
		puts '--list, -l: see the list'
		puts '--read N, -r N: show the N-th record'
		puts '--complete N, -c N: mark the N-th record as "done". If the N-th record is already "done", it should become "todo" again'
		puts '--delete N, -d N: remove the N-th record from the list (it should disappear from the file)'
		puts '--new some text, -n some text: creates a new record with title "some text"'
		puts '--update N some new text, -u N some new text: updated the N-th record title with "some new text"'
		puts '--help, -h: print out this information"'
	end

	def sysmessage(text)
		@text = text
		case @text
			when 'S'
				puts '! No such task!'
			when 'N'
				puts '! Enter the task number!'
			when 'T'
				puts '! Enter the task text!'
		end
	end

end

start = CLI.new(*ARGV)

