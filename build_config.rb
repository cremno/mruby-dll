MRuby::Build.new do |conf|
  toolchain :vs2012
  conf.cc.flags = %w(/c /nologo /W3 /MD /GL /O1 /Os /DHAVE_STRING_H /DNO_GETTIMEOFDAY /D_CRT_SECURE_NO_WARNINGS)
  conf.linker.flags = %w(/nologo /LTCG)
  conf.archiver.archive_options = '/nologo /LTCG /OUT:%{outfile} %{objs}'
end
