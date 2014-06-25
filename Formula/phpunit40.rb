require File.join(File.dirname(__FILE__), 'abstract-phpunit')

class Phpunit40 < AbstractPhpunit
  include AbstractPhpunitVersion::PhpUnit40Defs

  def phpunit_version
    4.0
  end

  def phpunit_version_path
    40
  end
end
