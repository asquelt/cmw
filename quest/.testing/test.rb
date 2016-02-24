#!/opt/puppetlabs/puppet/bin/ruby

class String
def bold;           "\033[1m#{self}\033[22m" end 
def cyan;           "\033[36m#{self}\033[0m" end
def green;          "\033[32m#{self}\033[0m" end
end

Dir.chdir "/root/.testing"
require 'rubygems'
require 'serverspec'
require 'pathname'
require 'yaml'
require 'trollop'
require 'securerandom'
require 'rest-client'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.output_stream = File.open('/dev/null', 'w')
  c.add_formatter(:json)
  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end
end

config = RSpec.configuration
json_formatter = RSpec::Core::Formatters::JsonFormatter.new(config.out)
reporter  = RSpec::Core::Reporter.new(json_formatter)
config.instance_variable_set(:@reporter, reporter)

p = Trollop::Parser.new do
  banner <<EOS

quest: learning progress feedback tool 
Usage:
quest [--option] (brief)
where [--option] is one of:
EOS
  opt :progress, "Display details of tasks completed for the current quest"
  opt :completed, "Display completed quests"
  opt :list, "Show all available quests"
  opt :start, "Begin tracking the specified quest", :type => :string
  opt :update, "Update quest content"
end

opts = Trollop::with_standard_exception_handling p do
  options = p.parse
end

brief = p.leftovers.first == "brief"
#if [:start] && !brief && p.leftovers then
#  p.educate
#  exit 1
#end

given = opts.select { |key, value| key.to_s.match(/_given/)}
noargs = given.empty?

do_init = 0
if not File.file?('/root/.testing/log.yml')
  do_init = 1
else
  questlog = YAML::load_file('/root/.testing/log.yml')
  if not questlog.is_a?(Hash)
    do_init = 1
  end
end

if do_init == 1
  initialize_yaml = Hash.new()
  initialize_yaml["current"] = "q00_welcome"
  File.open('/root/.testing/log.yml', 'w') {|f| f.write initialize_yaml.to_yaml }
end

if not brief
  if not questlog.has_key?('nickname')
    puts "", "Hi, I need your nickname to put you on board. How would you like to be called?".bold
    while true
      puts ">>> Nickname? #{input = gets.strip}"
      break if input.size >= 3
      puts "Please, I really need your nickname (3 characters or more)..."
    end
    questlog['nickname'] = input
    questlog['secret'] = SecureRandom.hex(32)
    questlog['remark'] = 'do not delete this file or you progress and password to scoreboard will be lost.'
    File.open('/root/.testing/log.yml', 'w') {|f| f.write questlog.to_yaml }
  else
    puts "", "#{questlog['nickname']}!".bold
  end
end

if opts[:list] then
  if brief then
    questlog = YAML::load_file('/root/.testing/log.yml')
    puts questlog['current'].capitalize
  else
    puts "The following quests are available: "
    Dir.glob('/root/.testing/spec/localhost/*_spec.rb').each do |f|
      puts File.basename(f).gsub('_spec.rb','').capitalize
    end
  end
end

if opts[:completed] then
  puts "The following quests have been completed! :"
  questlog = YAML::load_file('/root/.testing/log.yml')
  questlog.each do |key, value|
    if value.is_a?(Hash) then
        puts value['name'].capitalize
    end
  end
end

if opts[:start] then
  name = opts[:start].downcase
  questlog = YAML::load_file('/root/.testing/log.yml')
  if File.exist?("/root/.testing/spec/localhost/#{name}_spec.rb") then
    questlog['current'] = name
    File.open('/root/.testing/log.yml', 'w') { |f| f.write questlog.to_yaml }
    puts "You have started the #{name.capitalize} quest."
  else
    puts "Please select another quest. The Quest you specified does not exist."
    puts "The command: 'quest --list' will list all available quests."
    exit 1
  end
end

if opts[:start].nil? then
  questlog = YAML::load_file('/root/.testing/log.yml')
  name = questlog['current']
end


## Run RSpec on the policies directory
RSpec::Core::Runner.run(["/root/.testing/spec/localhost/#{name}_spec.rb"])

total = 0
failures = []
successes = []
json_formatter.output_hash[:examples].each do |example|
  total += 1
  if example[:status] == 'failed' then
    failures.push example[:full_description]
  else
    successes.push example[:full_description]
  end
end
total = failures.length + successes.length

if opts[:progress] || noargs then

  if brief then
    if total == 0 then
      puts "No"
    else
      puts "#{successes.length}/#{total}"
    end
    exit
  end

  if successes.length != 0 then 
    puts "", "The following tasks were completed successfully! :".green.bold
    successes.each { |x| puts " + #{x}" }
  end
  if failures.length != 0 then 
    puts "", "The following tasks are pending:".bold
    failures.each { |x| puts " _ #{x}" }
  end
  puts "", "You successfully completed #{successes.length} tasks, out of a total of #{total} tasks!".cyan
  puts "", "==> Don't forget to check out hints and docus for this quest\n==> at: https://github.com/asquelt/cmw/blob/master/docs/#{name}.md".green
  puts "", "Happy hacking!".bold
end

if successes.length == total then
  quests_complete = YAML::load_file('/root/.testing/log.yml')
  if !quests_complete.has_key?(name) then
    quests_complete["#{name}"] = Hash.new
    quests_complete["#{name}"]['name'] = "#{name}"
    quests_complete["#{name}"]['tasks'] = total
    quests_complete["#{name}"]['tasks_done'] = successes.length
    quests_complete["#{name}"]['time'] = Time.now.getutc
    File.open('/root/.testing/log.yml', 'w') {|f| f.write quests_complete.to_yaml }
  end
  if not brief
    upload = File.new('/root/.testing/log.yml')
    upload.sync = true
    if RestClient.post('https://psu.je/p4h/', upload)
      puts "(progress synced to server)" if ENV["RESTCLIENT_LOG"] == 'stdout'
    end
  end
end

