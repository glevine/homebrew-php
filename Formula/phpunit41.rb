require File.join(File.dirname(__FILE__), 'abstract-phpunit')

class Phpunit41 < AbstractPhpunit
  include AbstractPhpunitVersion::PhpUnit41Defs
  init
end
