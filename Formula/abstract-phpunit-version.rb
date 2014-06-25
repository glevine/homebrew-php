class AbstractPhpunitVersion < Formula
  def initialize name="__UNKNOWN__", *args
    begin
      raise "One does not simply install an AbstractPhpunit formula" if name == "abstract-phpunit-version"
      super
    rescue Exception => e
      # Hack so that we pass all brew doctor tests
      reraise = e.backtrace.select { |l| l.match(/(doctor|cleanup|leaves|uses)\.rb/) }
      raise e if reraise.empty?
    end
  end

  # Hack to allow 'brew uses' to work, which requires deps, version, and requirements
  %w(deps requirements version).each do |method|
    define_method(method) do
      if defined?(active_spec) && active_spec.respond_to?(method)
        active_spec.send(method)
      else
        method === 'version' ? 'abstract' : []
      end
    end
  end

  module PhpUnit37Defs
    PHPUNIT_HOME = 'http://phpunit.de/manual/3.7/en/'
    PHPUNIT_PHAR = 'https://phar.phpunit.de/phpunit-3.7.37.phar'
    PHPUNIT_SHA1 = '6eee1c707a3511a9326cb545a569e6870e116820'
    PHPUNIT_VERSION = '3.7'
  end

  module PhpUnit40Defs
    PHPUNIT_HOME = 'http://phpunit.de/manual/4.0/en/'
    PHPUNIT_PHAR = 'https://phar.phpunit.de/phpunit-4.0.20.phar'
    PHPUNIT_SHA1 = 'a2642f82d66c858077530d6fc5fbe1710c685003'
    PHPUNIT_VERSION = '4.0'
  end

  module PhpUnit41Defs
    PHPUNIT_HOME = 'http://phpunit.de/manual/4.1/en/'
    PHPUNIT_PHAR = 'https://phar.phpunit.de/phpunit-4.1.3.phar'
    PHPUNIT_SHA1 = '3975a93e0b3bdc0a7b61be2f36f50ee5c7d26c1d'
    PHPUNIT_VERSION = '4.1'
  end
end
