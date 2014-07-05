c_files           = FileList["*.c"]
object_files      = FileList["*.o"]
onig_object_files = object_files - ['print_regex.o']
ong_c_files       = c_files - ['print_regex.c']

# meh, spent a long time trying to think through this fuck it!
# although, this was super helpful if I want to come back to it
# http://jacobswanner.com/2014/03/17/rake-rule-tasks/
task 'Makefile' do
  sh './configure'
end

task :default do
  sh 'make'
  sh 'gcc -c print_regex.c'
  sh "gcc -o print_regex #{object_files.join(' ')}"
  sh "./print_regex"
end
