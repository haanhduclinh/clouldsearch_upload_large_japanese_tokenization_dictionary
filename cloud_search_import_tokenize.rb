require 'aws-sdk'
require 'yaml'
require 'json'
require 'pp'

config = YAML.load_file('aws/credentials.yml')

client = Aws::CloudSearch::Client.new(
  access_key_id: config['test']['access_key_id'],
  secret_access_key: config['test']['secret_access_key'],
  region: config['test']['region']
)

def insert_tokenize_json(client,file_path,domain_name,scheme_name)
  arr_data = File.read(file_path)
  client.define_analysis_scheme({
    domain_name: domain_name,
    analysis_scheme: {
      analysis_scheme_name: scheme_name,
      analysis_scheme_language: "ja", 
      analysis_options: {
        japanese_tokenization_dictionary: arr_data.to_s,
        algorithmic_stemming: "none"
      }
    }
  })
end

def get_japanese_tokenization_dictionary(client,domain_name,scheme_name)
  res = client.describe_analysis_schemes({
    domain_name: domain_name,
    analysis_scheme_names: [scheme_name],
    deployed: false
  })
  res.analysis_schemes[0].options.analysis_options.japanese_tokenization_dictionary
end

def delete_japanese_tokenization_dictionary(client,domain_name,scheme_name)
  res = client.delete_analysis_scheme({
    domain_name: domain_name,
    analysis_scheme_name: scheme_name
  })
  p "Done! Deleted '#{scheme_name}'" unless res.analysis_scheme
end

# USE
# ADD API_KEY AND SECRET_KEY in aws/credentials.yml

# INSERT
# pp insert_tokenize_json(client,'test','test-staging','ja_test')

# GET
# res = get_japanese_tokenization_dictionary(client,'test-staging','ja_test')
# pp JSON.parse res

# DELETE
# delete_japanese_tokenization_dictionary(client,'test-staging','ja_test')