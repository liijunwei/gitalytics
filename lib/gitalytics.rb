# encoding: UTF-8

require 'haml'
require 'matrix'
require 'parallel'
require 'gitalytics/commit'
require 'gitalytics/gitlog'
require 'gitalytics/gitlog_with_parallel'
require 'gitalytics/user'
require 'gitalytics/version'

module Gitalytics
  OUTPUT_FILE = 'gitalytics_result.html'.freeze

  module_function

  def analyze(options)
    data =
    if options[:parallel]
      GitlogWithParallel.parse_git_log(options[:group_by])
    else
      GitLog.parse_git_log(options[:group_by])
    end

    case options[:format]
    when 'html'
      output_html_report(data, options[:browser])
    else
      output_cli_report(data[:users])
    end
  end

  private

  module_function

  def output_cli_report(users)
    users.each do |user|
      # puts user.summary
    end
  end

  def prepare_data(data)
    @users = data[:users].sort { |x, y| y.commits.length <=> x.commits.length }
    @commits = data[:commits]
    weekday_commits = @users.map(&:weekday_commits)
    @weekday_commits = weekday_commits.map { |a| Vector[*a] }.inject(:+).to_a
  end

  def template_file
    dir           = File.dirname(__FILE__)
    filepath      = File.join(dir, '..', 'assets', 'gitalytics.html.haml')
    File.read(filepath)
  end

  def output_html_report(data, open_in_browser)
    File.open(OUTPUT_FILE, 'w+') do |file|
      prepare_data(data)
      file.write(Haml::Engine.new(template_file).render(self))
    end
    open_report_in_browser if open_in_browser
  end

  def open_report_in_browser
    case RbConfig::CONFIG['host_os']
    when /mswin|mingw|cygwin/
      system "start #{OUTPUT_FILE}"
    when /darwin/
      system "open #{OUTPUT_FILE}"
    when /linux|bsd/
      system "xdg-open #{OUTPUT_FILE}"
    end
  end
end
