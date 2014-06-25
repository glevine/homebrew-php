#encoding: utf-8

require 'formula'
require File.join(File.dirname(__FILE__), 'abstract-phpunit-version')
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

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

  def install
    libexec.install "phpunit-#{version.to_s}.phar"
    sh = libexec + command
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def command
    semver = {:major => 0, :minor => 0}
    v = version.to_s.split "."
    semver[:major] = v[0] unless v[0].nil? || v[0].empty?
    semver[:minor] = v[1] unless v[1].nil? || v[1].empty?
    raise "Must have at least a major or minor release" if semver[:major] == 0 && semver[:minor] == 0
    "phpunit#{semver.values.join}"
  end
end
