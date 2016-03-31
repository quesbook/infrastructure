ENV['AWS_PROFILE'] = 'quesbook'

class Terraform < Thor
  include Thor::Actions
  include Thor::Shell

  VAR_FILES = "-var-file='../../global.tfvars'"

  class_option :simulate, type: :boolean, default: false, aliases: [:s]
  class_option :terraform_bin, type: :string, default: 'terraform', aliases: [:bin]


  desc 'init ENVIRONMENT', 'Fetch state and modules for the given environment'
  def init(environment)
    valid_environment! environment

    cmd = [ "remote config -backend=S3 -backend-config='bucket=quesbook-engineering'",
            "-backend-config='key=terraform/#{environment}.tfstate'" ].join(' ')
    inside "terraform/environments/#{environment}" do
      run_terraform cmd
    end

    invoke :get
  end

  desc 'plan ENVIRONMENT', 'Generates an execution plan for the given environment'
  option :target, type: :array, desc: 'Resource(s) to target. Operation will be limited to this resource and its dependencies'
  def plan(environment)
    valid_environment! environment

    targets = ''
    if options[:target]
      targets = options[:target].map do |target|
        "-target=#{target}"
      end.join(' ')
    end

    inside "terraform/environments/#{environment}" do
      run_terraform "plan -module-depth=-1 #{VAR_FILES} -var 'environment=#{environment}' #{targets}"
    end
  end

  desc 'apply ENVIRONMENT', 'Builds or changes infrastructure for the given environment'
  option :target, type: :array, desc: 'Resource(s) to target. Operation will be limited to this resource and its dependencies'
  def apply(environment)
    valid_environment! environment

    targets = ''
    if options[:target]
      targets = options[:target].map do |target|
        "-target=#{target}"
      end.join(' ')
    end

    inside "terraform/environments/#{environment}" do
      run_terraform "apply #{VAR_FILES} -var 'environment=#{environment}' #{targets}"
    end if yes?("Are you sure you wish to apply the current plan to #{environment}?")
  end

  desc 'get ENVIRONMENT', 'Downloads and installs Terraform modules'
  def get(environment)
    valid_environment! environment

    inside "terraform/environments/#{environment}" do
      run_terraform 'get'
    end
  end

  desc 'taint ENVIRONMENT NAME', 'Manually taint a resource, forcing a destroy and recreate on the next plan/apply'
  option :module, type: :string
  def taint(environment, name)
    valid_environment! environment

    inside "terraform/environments/#{environment}" do
      if !options[:module]
        run_terraform "taint #{name}"
      else
        run_terraform "taint -module=#{options[:module]} #{name}"
      end
    end
  end

  desc 'localise ENVIRONMENT', 'Localise the state file by disabling the remote state'
  def localise(environment)
    valid_environment! environment

    inside "terraform/environments/#{environment}" do
      run_terraform 'remote config -disable'
    end
  end


  private

    def run_terraform(cmd)
      if options[:simulate]
        say_status :simulation, "#{options[:terraform_bin]} #{cmd}"
      else
        run("#{options[:terraform_bin]} #{cmd}", capture: true).split("\n").each do |line|
          say_status :terraform, line
        end
      end
    end

    def valid_environment!(env)
      inside 'terraform/environments' do
        unless Dir['*'].one? { |e| e == env && File.directory?(e) }
          raise_error "FAILURE: '#{env}' is not a valid environment"
        end
      end
    end

    def raise_error(message)
      raise Thor::Error, set_color(message, :red)
    end

end
