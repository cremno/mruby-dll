ctags_exe = 'ctags.exe'
mruby_include_dir = 'mruby/include'
files = Dir["#{mruby_include_dir}/*.h", "#{mruby_include_dir}/mruby/*.h"]
if files.empty?
  $stderr.puts 'Header files not found!'
  exit 1
end
File.open('mruby.def', 'w') do |f|
  f.puts 'LIBRARY mruby.dll'
  f.puts 'EXPORTS'
  IO.popen("#{ctags_exe} -u -x --c-kinds=p #{files.join(' ')}") do |io|
    io.each_line do |line|
      f.putc "\t"
      f.puts line[/^([A-Za-z_][\w]*)\b/]
    end
  end
end
