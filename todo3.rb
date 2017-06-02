# 2. --read N, -r N: show the N'th record

require 'csv'
todo_array = CSV.read('todolist.csv')

if ['-c', '--complete'].include?(ARGV.first)
	if ARGV[1] != nil
		n = ARGV[1].to_i - 1
		if todo_array[n] != nil
			if todo_array[n][2] == 'A'
				todo_array[n][2] = 'D'
				puts "Task #{ARGV[1]} is done!"
			else
				todo_array[n][2] = 'A'
				puts "Task #{ARGV[1]} is active!"				
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
