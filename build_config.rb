MRuby::Build.new do |conf|
  toolchain :vs2012
  conf.cc do |cc|
    cc.flags = %w(/c /nologo /W3 /MD /GL /O1 /Os /DHAVE_STRING_H /DNO_GETTIMEOFDAY /D_CRT_SECURE_NO_WARNINGS)
  end
  conf.linker do |linker|
    linker.flags = %w(/nologo /LTCG)
  end 
  conf.archiver do |archiver|
    archiver.archive_options = '/nologo /LTCG /OUT:%{outfile} %{objs}'
  end
end
