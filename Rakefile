file 'Makefile' => 'configure' do
  sh './configure'
end

file 'print_regex.c' => 'Makefile'
file 'print_regex.o' => 'print_regex.c'

task 'make' => 'Makefile' do
  sh 'make'
end

rule '.o' => 'make' do |task|
  if task.name == 'print_regex.o'
    sh 'gcc -c print_regex.c'
  end
end

rule 'print_regex' => '.o' do |t|
  puts "now link"
  sh "gcc -o #{t.name} #{FileList["*.o"].join(' ')}"
  sh "./#{t.name}"
end

task 'run' => 'print_regex'

task default: 'run'
