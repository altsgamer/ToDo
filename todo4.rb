# 4. --delete N, -d N: remove the N'th record from the list (it should disappear from the file)

require 'csv'
todo_array = CSV.read('todolist.csv')

puts "#{todo_array.inspect}\n "

if ['-d', '--delete'].include?(ARGV[0])
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
else
	puts "unknown command"
end

CSV.open('todolist.csv', 'wb') do |csv|
	todo_array.each do |a|
		csv << a
	end
end
