# guard 'migrate' do
#   watch(%r{^db/migrate/(\d+).+\.rb})
#   watch('db/seeds.rb')
# end

# guard 'rails' do
#   watch('Gemfile.lock')
#   watch(%r{^(config|lib)/.*})
# end

# guard :bundler do
#   require 'guard/bundler'
#   require 'guard/bundler/verify'
#   helper = Guard::Bundler::Verify.new

#   files = ['Gemfile']
#   files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

#   files.each { |file| watch(helper.real_path(file)) }
# end

guard 'livereload' do
  extensions = {
    css: :css,
    scss: :css,
    sass: :css,
    js: :js,
    coffee: :js,
    html: :html,
    # slim: :html,
    png: :png,
    gif: :gif,
    jpg: :jpg,
    jpeg: :jpeg,
  }
  rails_view_exts = %w(erb haml slim)
  compiled_exts = extensions.values.uniq
  watch(%r{public/.+\.(#{compiled_exts * '|'})})
  extensions.each do |ext, type|
    watch(%r{
          (?:app|vendor)
          (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
           (?<ext>\.#{ext})) # matching extension (must be first encountered)
          (?:\.\w+|$) # other extensions
          }x) do |m|
      path = m[1]
      "/assets/#{path}.#{type}"
    end
  end
  watch(%r{app/views/.+\.(#{rails_view_exts * '|'})$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{config/locales/.+\.yml})
end


guard :rspec, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  rails = dsl.rails(view_extensions: %w(erb haml slim))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [
      rspec.spec.("routing/#{m[1]}_routing"),
      rspec.spec.("controllers/#{m[1]}_controller"),
      rspec.spec.("acceptance/#{m[1]}")
    ]
  end

  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  watch(rails.view_dirs)     { |m| rspec.spec.("features/#{m[1]}") }
  watch(rails.layouts)       { |m| rspec.spec.("features/#{m[1]}") }

  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || "spec/acceptance"
  end
end

# guard :shell do
#   watch(/(.*).txt/) {|m| `tail #{m[0]}` }
# end

# guard 'zeus' do
#   require 'ostruct'

#   rspec = OpenStruct.new
#   rspec.spec_dir = 'spec'
#   rspec.spec = ->(m) { "#{rspec.spec_dir}/#{m}_spec.rb" }
#   rspec.spec_helper = "#{rspec.spec_dir}/spec_helper.rb"

#   rspec.spec_files = /^#{rspec.spec_dir}\/.+_spec\.rb$/

#   ruby = OpenStruct.new
#   ruby.lib_files = /^(lib\/.+)\.rb$/

#   watch(rspec.spec_files)
#   watch(rspec.spec_helper) { rspec.spec_dir }
#   watch(ruby.lib_files) { |m| rspec.spec.call(m[1]) }

#   rails = OpenStruct.new
#   rails.app_files = /^app\/(.+)\.rb$/
#   rails.views_n_layouts = /^app\/(.+(?:\.erb|\.haml|\.slim))$/
#   rails.controllers = %r{^app/controllers/(.+)_controller\.rb$}

#   watch(rails.app_files) { |m| rspec.spec.call(m[1]) }
#   watch(rails.views_n_layouts) { |m| rspec.spec.call(m[1]) }
#   watch(rails.controllers) do |m|
#     [
#       rspec.spec.call("routing/#{m[1]}_routing"),
#       rspec.spec.call("controllers/#{m[1]}_controller"),
#       rspec.spec.call("acceptance/#{m[1]}")
#     ]
#   end

# end
