require File.join(File.dirname(__FILE__), 'abstract-phpunit')

class Phpunit41 < AbstractPhpunit
  include AbstractPhpunitVersion::PhpUnit41Defs

  def phpunit_version
    4.1
  end

  def phpunit_version_path
    41
  end
end
