# 1. --list, -l: see the list

#flags = ARGV
# if flags[0] == '-l' 
# 	puts IO.read('todolist.csv')
# else
# 	puts "unknown command"
# end

if ['-l', '--list'].include?(ARGV.first)
	puts IO.read('todolist.csv')
else
	puts "unknown command"
end

