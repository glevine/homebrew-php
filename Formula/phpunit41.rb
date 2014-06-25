require File.join(File.dirname(__FILE__), 'abstract-phpunit')

class Phpunit41 < AbstractPhpunit
  include AbstractPhpunitVersion::PhpUnit41Defs
  homepage PHPUNIT_HOME
  url PHPUNIT_PHAR
  sha1 PHPUNIT_SHA1
  version PHPUNIT_VERSION
end
