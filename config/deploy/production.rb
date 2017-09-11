role :app, %w{deployer@85.143.218.55}
role :web, %w{deployer@85.143.218.55}
role :db,  %w{deployer@85.143.218.55}

set :rails_env, :production
set :stage, :production

server '85.143.218.55', user: 'deployer', roles: %w{web app db}, primary: true

set :ssh_options, {
   keys: %w(/home/q/.ssh/id_rsa),
   forward_agent: true,
   auth_methods: %w(publickey password),
   port: 4321
}
