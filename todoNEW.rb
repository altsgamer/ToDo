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
		puts @todo_array[n][1]
	end

	def complete(n)
		if @todo_array[n] != nil
			if @todo_array[n][0] == 'A'
				@todo_array[n][0] = 'D'
				puts "Task #{n+1} is done!"
			else
				@todo_array[n][0] = 'A'	
				puts "Task #{n+1} is active!"
			end	
		else
			puts '! No such task!'
		end
		write
	end

	def delete(n)
		if @todo_array[n] != nil
			@todo_array[n] = nil
			@todo_array = @todo_array.compact
			puts "Task #{n+1} deleted!"
		else
			puts '! No such task!'
		end		
		write
	end

	def newl(t)
		@todo_array.push ['A', t]
		puts "Active task number #{@todo_array.count} added."
		write
	end

	def update (n,t)
		if @todo_array[n] != nil
			@todo_array[n][1] = t
			puts "Task #{n+1} updated!"
		else
			puts '! No such task!'
		end
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
	    verifyARGV
	    td = TodoList.new
		case @arg[0]
			when ('-h' || '--help')
				help
			when ('-l' || '--list')
				td.list
			when ('-r' || '--read')
				@num == -1 ? sysmessage('N') : td.read(@num)
			when ('-c' || '--complete')
				@num == -1 ? sysmessage('N') : td.complete(@num)
			when ('-d' || '--delete')
				@num == -1 ? sysmessage('N') : td.delete(@num)
			when ('-n' || '--new')
				@text == nil ? sysmessage('T') : td.newl(@text)
			when ('-u' || '--update')
				if @num != -1
					@text == nil ? sysmessage('T') : td.update(@num, @text)
				else
					sysmessage('N')
				end	
		else 
			puts "! Unknown command!"
		help
		end
	end

	def verifyARGV
		@num = @arg[1].to_i-1
		@num != -1 ? @text = @arg[2] : @text = @arg[1]
	end	

	def help
		puts 'Commands for todo.rb:'
		puts '--list, -l: see the list'
		puts '--read N, -r N: show the N-th record'
		puts '--complete N, -c N: mark the N-th record as "done". If the N-th record is already "done", it should become "todo" again'
		puts '--delete N, -d N: remove the N-th record from the list (it should disappear from the file)'
		puts '--new "some text", -n "some text": creates a new record with title "some text"'
		puts '--update N "some new text", -u N "some new text": updated the N-th record title with "some new text"'
		puts '--help, -h: print out this information"'
	end

	def sysmessage(t)
		@text = t
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

