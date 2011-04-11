# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Purchest::Application.initialize!

# Load global constants file
GLOBAL_CONSTANTS = YAML.load_file("#{RAILS_ROOT}/config/global_constants.yml")