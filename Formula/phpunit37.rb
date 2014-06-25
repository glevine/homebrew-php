require File.join(File.dirname(__FILE__), 'abstract-phpunit')

class Phpunit37 < AbstractPhpunit
  include AbstractPhpunitVersion::PhpUnit37Defs

  def phpunit_version
    3.7
  end

  def phpunit_version_path
    37
  end
end
