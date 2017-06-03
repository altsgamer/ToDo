# 5. --new some text, -n some text: creates a new record with title "some text"

require 'csv'
todo_array = CSV.read('todolist.csv')

if ['-n', '--new'].include?(ARGV[0])
	if ARGV[1] != nil
		n = todo_array.count
		todo_array.push [n, ARGV[1], 'A']
		puts "active task number #{n} added"
	else
		puts 'enter the task text'
	end
else
	puts 'unknown command'
end

CSV.open('todolist.csv', 'wb') do |csv|
	todo_array.each do |a|
		csv << a
	end
end
