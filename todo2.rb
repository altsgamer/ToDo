# 2. --read N, -r N: show the N'th record

require 'csv'
todo_array = CSV.read('todolist.csv')

if ['-r', '--read'].include?(ARGV.first)
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
else
	puts "unknown command"
end
