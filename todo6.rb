# 6. --update N some new text, -u N some new text:
# updated the N'th record's title with "some new text"

require 'csv'
todo_array = CSV.read('todolist.csv')

puts "#{todo_array.inspect}\n "

if ['-u', '--update'].include?(ARGV[0])
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
