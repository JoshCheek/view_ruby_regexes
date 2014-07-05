c_files           = FileList["*.c"]
object_files      = FileList["*.o"]
onig_object_files = object_files - ['print_regex.o']
ong_c_files       = c_files - ['print_regex.c']

# meh, spent a long time trying to think through this fuck it!
# although, this was super helpful if I want to come back to it
# http://jacobswanner.com/2014/03/17/rake-rule-tasks/
desc 'Configure after first downloading, need to configure (this generates the makefile)'
task(:configure) { sh './configure' }


desc 'Compiles Oniguruma code, need to do this after editing any of it'
task(:onig) { sh 'make' }
desc 'Alias for onig'
task o: :onig

desc 'Compiles print_regex.c into print_regex executable'
task :compile do
  # sh 'gcc -c print_regex.c'
  # sh "gcc -o print_regex #{object_files.join(' ')}"
  sh "gcc -o print_regex print_regex.c #{onig_object_files.join ' '}"
end
desc 'Alias for compile'
task c: :compile


desc 'Runs the program, handing it a prefab regex'
task :run do
  sh "./print_regex 'a|bcd?e{100}f{2,3}|(-?\d+)'"
end
desc 'Alias for run'
task r: :run


desc 'Recompile everything and run'
task newrun: [:compile, :run]

desc 'Does a newrun'
task default: :newrun
