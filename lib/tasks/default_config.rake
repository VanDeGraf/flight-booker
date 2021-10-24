namespace :default_config do
  require "fileutils"

  desc "Set webpack as main(instead rails pipeline), rename some dirs"
  task :set_webpack_config do
    assets_dir_name = "frontend"
    fs_rename("app", "javascript", assets_dir_name)
    fs_rename("app/#{assets_dir_name}", "packs", "entry")
    fs_create("app/#{assets_dir_name}/entry", "application.scss")
    fs_mkdir("app/#{assets_dir_name}", "src")
    fs_mkdir("app/#{assets_dir_name}", "stylesheet")
    replace_in_file("config", "webpacker.yml", {
      /source_path: app\/javascript/ => "source_path: app/#{assets_dir_name}",
      /source_entry_path: packs/ => "source_entry_path: entry",
      /public_output_path: packs/ => "public_output_path: #{assets_dir_name}",
      /public_output_path: packs-test/ => "public_output_path: #{assets_dir_name}-test",
    })
    replace_in_file("app/views/layouts", "application.html.erb", {
      /stylesheet_link_tag/ => "stylesheet_pack_tag"
    })
    replace_in_file("", ".gitignore", {
      /\/public\/packs/ => "/public/#{assets_dir_name}",
      /\/public\/packs-test/ => "/public/#{assets_dir_name}-test",
    })
    puts "Successfully set default webpack config!"
  end

  desc "TODO"
  task :install_bootstrap do
  end

  desc "TODO"
  task :install_simple_form do
  end

  desc "TODO"
  task :install_devise do
  end

  desc "Run all commands of this namespace in right order"
  task :install_all do
    [
      %{ rails default_config:set_webpack_config },
      %{ rails default_config:install_bootstrap },
      %{ rails default_config:install_simple_form },
      %{ rails default_config:install_devise },
    ].each do |command|
      unless run_command(command)
        puts "Interrupted install, please continue manually!"
        return
      end
    end
    puts "Successfully install all default configs!"
  end

  # @return [Boolean]
  def run_command(cmd)
    sh cmd do |ok, res|
      unless ok
        puts "Command exec error (status = #{res.exitstatus})"
        return false
      end
    end
    return true
  end

  # @param relative_parent_path [String]
  # @param filename [String]
  # @param replacing [Hash<String, String>] { regex_find => replace_string }
  def replace_in_file(relative_parent_path, filename, replacing)
    filepath = "#{Dir.pwd}/#{relative_parent_path}/#{filename}"
    return unless File.exist?(filepath)

    replacement_counter = 0
    IO.write(filepath, File.open(filepath) do |f|
      content = f.read
      replacing.each_pair do |regex, replace|
        content = content.gsub(regex) do |_|
          replacement_counter += 1
          replace
        end
      end
      content
    end)
    unless replacement_counter.zero?
      puts "#{relative_parent_path}/#{filename}: updated #{replacement_counter} times "
    end
  end

  def fs_rename(relative_parent_path, old_name, new_name)
    path = "#{Dir.pwd}/#{relative_parent_path}/#{old_name}"
    return unless Dir.exist?(path) || File.exist?(path)

    FileUtils.mv(path, "#{Dir.pwd}/#{relative_parent_path}/#{new_name}")
    puts "#{relative_parent_path}/#{new_name}: renamed from '#{old_name}'"
  end

  def fs_create(relative_parent_path, name)
    path = "#{Dir.pwd}/#{relative_parent_path}/#{name}"
    return if File.exist?(path) || Dir.exist?(path)

    FileUtils.touch(path)
    puts "#{relative_parent_path}/#{name}: created"
  end

  def fs_mkdir(relative_parent_path, name)
    path = "#{Dir.pwd}/#{relative_parent_path}/#{name}"
    return if File.exist?(path) || Dir.exist?(path)

    FileUtils.mkdir(path)
    puts "#{relative_parent_path}/#{name}: created"
  end
end
