
require 'csv'
unless File.file?('todolist.csv')
	File.new('todolist.csv', 'w')
end

todo_array = CSV.read('todolist.csv')

argument_command = ARGV[0]
case argument_command

# 1. --list, -l: see the list
	when ('-l' || '--list')
		puts IO.read('todolist.csv')

# 2. --read N, -r N: show the N'th record
	when ('-r' || '--read')
		if ARGV[1] != nil
			n = ARGV[1].to_i - 1
			if todo_array[n] != nil
				puts todo_array[n][1]
			else
				puts "no such task"
			end
		else
			puts "enter the task number"
		end

# 3. --complete N, -c N: mark the N'th record as "done".
# If the N'th record is already "done", it should become "todo" again.
	when ('-c' || '--complete')
		if ARGV[1] != nil
			n = ARGV[1].to_i - 1
			if todo_array[n] != nil
				if todo_array[n][0] == 'A'
					todo_array[n][0] = 'D'
					puts "Task #{ARGV[1]} is done!"
				else
					todo_array[n][0] = 'A'
					puts "Task #{ARGV[1]} is active!"				
				end
			else
				puts "no such task"
			end
		else
			puts "enter the task number"
		end

# 4. --delete N, -d N: remove the N'th record from the list (it should disappear from the file)
	when ('-d' || '--delete')
		if ARGV[1] != nil
			n = ARGV[1].to_i - 1
			if todo_array[n] != nil
					todo_array[n] = nil
					todo_array = todo_array.compact
					puts "Task #{ARGV[1]} deleted!"
			else
				puts "no such task"
			end
		else
			puts "enter the task number"
		end

# 5. --new some text, -n some text: creates a new record with title "some text"
	when ('-n' || '--new')
		if ARGV[1] != nil
			i = 1
			String.new(t="")
			until i >= ARGV.length
				t = t + ARGV[i] + ' ' 
				i += 1
			end
			todo_array.push ['A', t]
			puts "active task number #{todo_array.count} added"
		else
			puts 'enter the task text'
		end

# 6. --update N some new text, -u N some new text:
# updated the N'th record's title with "some new text"
	when ('-u' || '--update')
		if ARGV[1] != nil		
			n = ARGV[1].to_i - 1		
			if todo_array[n] != nil
					if ARGV[2] != nil		
						String.new(t="")
						i = 2
						until i >= ARGV.length
							t = t + ARGV[i] + ' ' 
							i += 1
						end
							todo_array[n][1] = t
							puts "Task #{ARGV[1]} updated!"
					else
						puts 'enter the task text'
					end
			else
				puts "no such task"
			end
		else
			puts "enter the task number"
		end

else 
	puts "unknown command"
end

CSV.open('todolist.csv', 'wb') do |csv|
	todo_array.each do |a|
		csv << a
	end
end

