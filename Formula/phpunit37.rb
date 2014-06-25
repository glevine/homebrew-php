require File.join(File.dirname(__FILE__), 'abstract-phpunit')

class Phpunit37 < AbstractPhpunit
  include AbstractPhpunitVersion::PhpUnit37Defs
  init
end
