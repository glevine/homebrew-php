require File.join(File.dirname(__FILE__), 'abstract-phpunit')

class Phpunit40 < AbstractPhpunit
  include AbstractPhpunitVersion::PhpUnit40Defs
  homepage PHPUNIT_HOME
  url PHPUNIT_PHAR
  sha1 PHPUNIT_SHA1
  version PHPUNIT_VERSION
end
