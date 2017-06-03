TodoApp is a CLI app to manages todo records.

A user wants to read a list of todos, see the detailed description of each todo, mark them as "done".

All lists should be stored in a plain text file in the script directory. Any todo item should store a title (required), a created_at date and time, and a status (done or not done).

The app should be run with `ruby todo.rb` command. A user can specify an action with parameter flags.

Flags:

1. --list, -l: see the list
2. --read N, -r N: show the N'th record
3. --complete N, -c N: mark the N'th record as "done". If the N'th record is already "done", it should become "todo" again.
4. --delete N, -d N: remove the N'th record from the list (it should disappear from the file)
5. --new some text, -n some text: creates a new record with title "some text"
6. --update N some new text, -u N some new text: updated the N'th record's title with "some new text"
