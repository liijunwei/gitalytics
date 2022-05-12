require 'gitalytics/commit'
require 'gitalytics/user'
require 'date'
require 'pry'

module GitlogWithParallel
  module_function

  @users   = []
  @commits = []

  def parse_git_log(group_by)
    blocks = get_blocks(get_log)

    Parallel.each(blocks, in_threads: Etc.nprocessors) do |(hash, block_string)|
      @commits << parse_block(hash, block_string, group_by)
    end

    { users: @users, commits: @commits }
  end

  def get_log
    `git log --numstat --pretty='%H %ai %an <%ae> %s'`
  end

  def get_blocks(log_string)
    commits = log_string.scan(/^([a-f0-9]{40})/).map(&:first)
    blocks  = log_string.split(/^[a-f0-9]{40}/).map(&:strip)
    blocks.shift # get rid of first empty string

    commits.zip(blocks)
  end

  def parse_block(hash, block_string, group_by)
    commit = Commit.new(hash)

    block_string.encode!('UTF-8', 'UTF8-MAC') if defined?(Encoding::UTF8_MAC)

    regex = /^(?<date>.{25}) (?<name>.*?) \<(?<email>.*?)> (?<subject>.*?)$/
    data = block_string.match(regex)
    commit.subject = data[:subject]
    commit.date = Date.parse(data[:date])

    get_commit_author(data, commit, group_by)
    get_commit_summary(block_string, commit)

    commit
  end

  def get_commit_summary(block_string, commit)
    regex = /^(?<insertions>\d+)\s+(?<deletions>\d+)\s+(?<filename>.*)$/
    Parallel.each(block_string.scan(regex), in_threads: Etc.nprocessors) do |summary|
      commit.summary << {
        insertions: summary[0].to_i,
        deletions: summary[1].to_i,
        filename: summary[2]
      }
    end
  end

  def get_commit_author(data, commit, group_by)
    user = get_user(data[:name], data[:email], group_by)

    commit.author = user
    user.commits << commit
  end

  def get_user(name, email, group_by)
    case group_by
    when 'name'
      u = @users.index { |user| user.name == name }
    when 'email'
      u = @users.index { |user| user.email == email }
    end
    return @users[u] if u
    @users << new_user = User.new(name, email)
    new_user
  end
end
