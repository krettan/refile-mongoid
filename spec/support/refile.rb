require "refile"

Refile.cache = Refile::Backend::FileSystem.new(Dir.tmpdir)
Refile.store = Refile::Backend::FileSystem.new(Dir.tmpdir)
