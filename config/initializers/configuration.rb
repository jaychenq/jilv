CONFIG = RecursiveOpenStruct.new(YAML.load_file(File.join(Rails.root, 'config', 'configuration.yml')), recurse_over_arrays: true)
  