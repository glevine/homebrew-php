#encoding: utf-8

require 'formula'
require File.join(File.dirname(__FILE__), 'abstract-phpunit-version')

class AbstractPhpunit < Formula
  def initialize name="__UNKNOWN__", *args
    begin
      raise "One does not simply install an AbstractPhpunit formula" if name == "abstract-phpunit"
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

  def init
    @homepage = PHPUNIT_HOME
    @url = PHPUNIT_PHAR
    @sha1 = PHPUNIT_SHA1
    @version = PHPUNIT_VERSION
  end

  def install
    command = @version.delete "."
    libexec.install "phpunit-#{version}.phar"
    sh = libexec + "phpunit#{command}"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end
end
