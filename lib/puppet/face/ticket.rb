require 'puppet'
require 'puppet/face'
require 'puppet/util/redmine_client'
require 'json'
require 'readline'
require 'pp'

Puppet::Face.define(:ticket, '0.0.1') do
  summary "Create Puppet Redmine tickets from the command line"
  copyright "James Turnbull", 2011
  license   "Apache 2 license; see LICENSE"

  option "--token TOKEN" do
    desc "Your Puppet Labs Redmine user API token"
  end

  action :create do
    summary "Create a Redmine ticket"
    description <<-EOT
      Creates a ticket in the Puppet Labs Redmine instance. You must specify your Redmine user API 
      token, found at http://projects.puppetlabs.com/my/account, using the --token option.
    EOT

    when_invoked do |options|
      fail "You must specify an API token to create a ticket" if options[:token].nil?
      redmine_url
      login_redmine(options[:token],redmine_url)
      @project_list = get_redmine_projects
      create_redmine_ticket
    end
  end

  action :list do
    summary "List a Redmine ticket"
    description <<-EOT
      List a Redmine ticket by specifying its ticket number, i.e. #1234.
    EOT

    option "--ticket TICKET" do
      desc "The Redmine ticket to show, i.e. #1234"
    end

    when_invoked do |options|
      fail "You must specify a ticket number" if options[:ticket].nil?
      ticket = options[:ticket].gsub(/#/, '')
      redmine_url
      login_redmine(token=nil,redmine_url)
      list_ticket(ticket)
    end
  end

  def redmine_url
    "http://projects.puppetlabs.com"
  end

  def login_redmine(token,redmine_url)
    Puppet::Util::RedmineClient::Base.configure do
      self.site = redmine_url
      self.user = token unless token == nil
    end
    Puppet.debug "Connected to #{redmine_url} Redmine instance..."
  end

  def get_redmine_projects
    project_list = {}
    projects = Puppet::Util::RedmineClient::Project.find(:all)
    projects.each do |p|
      project_list[p.id] = p.identifier
    end
    Puppet.debug "Getting list of projects from Redmine."
    return project_list
  end

  def create_redmine_ticket
    # Trap INT for ^C
    trap('INT') { exit }

    puts "Create a new Redmine ticket specifing the project, a title and a description. End each entry with <Enter> or ^C to cancel"
    puts "Project to log a ticket to, for example Puppet or Facter"

    project = Readline.readline("Project: ", true).downcase
    title = Readline.readline("Ticket title: ", true)
    body = Readline.readline("Ticket Description: ", true)

    id = @project_list.index(project) if @project_list.has_value?(project)
    if id == nil
      fail "Unknown Redmine project."
    end

    issue = Puppet::Util::RedmineClient::Issue.new(
         :subject => title,
         :project_id => id,
         :description => body
    )
    pp issue
    #if issue.save
    #  url = "#{@rm_site}/issues/#{issue.id}"
    #  close_pull_request(number,repo,url)
    #else
    #  puts issue.errors.full_messages
    #end
  end

  def list_ticket(ticket)
    issue = Puppet::Util::RedmineClient::Issue.find(ticket)
    puts "Issue #{ticket} is '#{issue.subject}' in the #{issue.project.name} project and has a status of '#{issue.status.name}'. " + "\n"
         "You can find it at #{redmine_url}/issues/#{ticket}"
  end
end
