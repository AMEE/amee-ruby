# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{amee-ruby}
  s.version = "2.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Smith"]
  s.date = %q{2011-07-15}
  s.default_executable = %q{ameesh}
  s.email = %q{james@floppy.org.uk}
  s.executables = ["ameesh"]
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".rvmrc",
    "CHANGELOG",
    "COPYING",
    "Gemfile",
    "README",
    "Rakefile",
    "VERSION",
    "amee.example.yml",
    "bin/ameesh",
    "cacert.pem",
    "examples/create_profile.rb",
    "examples/create_profile_item.rb",
    "examples/list_profiles.rb",
    "examples/view_data_category.rb",
    "examples/view_data_item.rb",
    "examples/view_profile_item.rb",
    "init.rb",
    "lib/amee.rb",
    "lib/amee/collection.rb",
    "lib/amee/connection.rb",
    "lib/amee/data_category.rb",
    "lib/amee/data_item.rb",
    "lib/amee/data_item_value.rb",
    "lib/amee/data_item_value_history.rb",
    "lib/amee/data_object.rb",
    "lib/amee/drill_down.rb",
    "lib/amee/exceptions.rb",
    "lib/amee/item_definition.rb",
    "lib/amee/item_value_definition.rb",
    "lib/amee/logger.rb",
    "lib/amee/object.rb",
    "lib/amee/pager.rb",
    "lib/amee/parse_helper.rb",
    "lib/amee/profile.rb",
    "lib/amee/profile_category.rb",
    "lib/amee/profile_item.rb",
    "lib/amee/profile_item_value.rb",
    "lib/amee/profile_object.rb",
    "lib/amee/rails.rb",
    "lib/amee/shell.rb",
    "lib/amee/user.rb",
    "rails/init.rb",
    "spec/amee_spec.rb",
    "spec/cache_spec.rb",
    "spec/connection_spec.rb",
    "spec/data_category_spec.rb",
    "spec/data_item_spec.rb",
    "spec/data_item_value_history_spec.rb",
    "spec/data_item_value_spec.rb",
    "spec/data_object_spec.rb",
    "spec/drill_down_spec.rb",
    "spec/fixtures/AD63A83B4D41.json",
    "spec/fixtures/AD63A83B4D41.xml",
    "spec/fixtures/data.json",
    "spec/fixtures/data.xml",
    "spec/fixtures/data_home_energy_quantity.xml",
    "spec/fixtures/data_home_energy_quantity_biodiesel.xml",
    "spec/fixtures/data_transport_car_generic_drill_fuel_diesel.xml",
    "spec/fixtures/empty.json",
    "spec/fixtures/empty.xml",
    "spec/fixtures/parse_test.xml",
    "spec/fixtures/v0_data_transport_transport_drill_transportType_Car1.xml",
    "spec/item_definition_spec.rb",
    "spec/item_value_definition_spec.rb",
    "spec/logger_spec.rb",
    "spec/object_spec.rb",
    "spec/parse_helper_spec.rb",
    "spec/profile_category_spec.rb",
    "spec/profile_item_spec.rb",
    "spec/profile_item_value_spec.rb",
    "spec/profile_object_spec.rb",
    "spec/profile_spec.rb",
    "spec/rails_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/user_spec.rb"
  ]
  s.homepage = %q{http://github.com/Floppy/amee-ruby}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.1}
  s.summary = %q{Ruby interface to the AMEE carbon calculator}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["~> 2.3.5"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<log4r>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.4.3.1"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rspec_spinner>, ["= 1.1.3"])
    else
      s.add_dependency(%q<activesupport>, ["~> 2.3.5"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<log4r>, [">= 0"])
      s.add_dependency(%q<nokogiri>, ["~> 1.4.3.1"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rspec_spinner>, ["= 1.1.3"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 2.3.5"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<log4r>, [">= 0"])
    s.add_dependency(%q<nokogiri>, ["~> 1.4.3.1"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rspec>, ["= 1.3.0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rspec_spinner>, ["= 1.1.3"])
  end
end

