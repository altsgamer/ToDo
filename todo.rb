if ['-l', '--list'].include?(ARGV.first)
	puts IO.read('todolist.csv')
else
	puts "unknown command"
end













