class Chef < Thor
  include Thor::Actions
  include Thor::Shell


  desc 'push ROLE ENVIRONMENT', 'Update and push the given role to the given environment'
  option :only, type: :boolean
  def push(role, environment)
    valid_role! role

    if environment == 'production' && !yes?("Are you sure you wish to push to production?")
      return
    end

    inside "cookbooks/roles/#{role}" do
      run_chef 'update' unless options[:only]
      run_chef "push #{environment}"
    end
  end

  desc 'update ROLE', 'Update the given role'
  def update(role)
    valid_role! role

    inside "cookbooks/roles/#{role}" do
      run_chef 'update'
    end
  end


  private

    def run_chef(cmd)
      run("chef #{cmd}", capture: true).split("\n").each do |line|
        say_status :chef, line
      end
    end

    def valid_role!(role)
      inside 'cookbooks/roles' do
        unless Dir['*'].one? { |e| e == role && File.directory?(e) }
          raise_error "FAILURE: '#{role}' is not a valid role"
        end
      end
    end

    def raise_error(message)
      raise Thor::Error, set_color(message, :red)
    end

end
