MRuby::Build.new do |conf|
  toolchain :vs2012
  conf.cc.flags = %w(/c /nologo /W3 /MD /GL /O1 /DHAVE_STRING_H /DNO_GETTIMEOFDAY /D_CRT_SECURE_NO_WARNINGS)
  conf.linker.flags = %w(/nologo /LTCG)
  conf.archiver.archive_options = '/nologo /LTCG /OUT:%{outfile} %{objs}'

  # Use standard Kernel#sprintf method
  conf.gem "#{root}/mrbgems/mruby-sprintf"

  # Use standard print/puts/p
  conf.gem "#{root}/mrbgems/mruby-print"

  # Use standard Math module
  conf.gem "#{root}/mrbgems/mruby-math"

  # Use standard Time class
  conf.gem "#{root}/mrbgems/mruby-time"

  # Use standard Struct class
  conf.gem "#{root}/mrbgems/mruby-struct"

  # Use extensional Enumerable module
  conf.gem "#{root}/mrbgems/mruby-enum-ext"

  # Use extensional String class
  conf.gem "#{root}/mrbgems/mruby-string-ext"

  # Use extensional Numeric class
  conf.gem "#{root}/mrbgems/mruby-numeric-ext"

  # Use extensional Array class
  conf.gem "#{root}/mrbgems/mruby-array-ext"

  # Use extensional Hash class
  conf.gem "#{root}/mrbgems/mruby-hash-ext"

  # Use Random class
  conf.gem "#{root}/mrbgems/mruby-random"

  # Generate mirb command
  conf.gem "#{root}/mrbgems/mruby-bin-mirb"

  # Generate mruby command
  conf.gem "#{root}/mrbgems/mruby-bin-mruby"

end
