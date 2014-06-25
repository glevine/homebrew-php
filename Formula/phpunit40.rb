require File.join(File.dirname(__FILE__), 'abstract-phpunit')

class Phpunit40 < AbstractPhpunit
  include AbstractPhpunitVersion::PhpUnit40Defs
  init
end
