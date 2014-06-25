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

  def phpunit_version
    raise "Unspecified phpunit version"
  end

  def php_version_path
    raise "Unspecified php version path"
  end

  def install
    # Ensure this php has a version specified
    php_version
    php_version_path
    libexec.install "phpunit-#{version}.phar"
    sh = libexec + "phpunit#{phpunit_version_path.to_s}"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end
end
