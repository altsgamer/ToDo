class TodoList
end

class TodoItem
end

class CommandLineInterface # это суперправильно - разделить эту задачу на 3 сущности?
	def initialize
		unless File.file?('todolist.csv')  # проверяем наличие файла, если нет - создаём
			File.new('todolist.csv', 'w')
		end
		@list = TodoList.load('todolist.csv')
	end

	def help
	end
	def list
	end
	def read
	end
	def complete
	end
	def delete
	end
	def new
	end
	def update
	end

	def write
	end

end

require 'csv' # или это в начало кода? или внутрь какого-то класса?

cli = CommandLineInterface.new

case ARGV[0]
	when ('-h' || '--help')
		cli.help
	when ('-l' || '--list')
		cli.list
	when ('-r' || '--read')
		cli.read
	when ('-l' || '--list')
		cli.complete
	when ('-c' || '--complete')
		cli.list
	when ('-d' || '--delete')
		cli.list
	when ('-n' || '--new')
		cli.list
	when ('-u' || '--update')
		cli.update
else 
	puts "unknown command"
	cli.help
end

cli.write