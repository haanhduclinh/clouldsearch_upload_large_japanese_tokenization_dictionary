# clouldsearch_upload_large_japanese_tokenization_dictionary
Upload more than 10.000 keywords keyword in japanese_tokenization_dictionary via aws api

# GEM INSTALL

+ `gem install 'aws-sdk-v1`

# USE
+ ADD API_KEY AND SECRET_KEY in aws/credentials.yml

# INSERT
```ruby
pp insert_tokenize_json(client,'test','test-staging','ja_test')
```

# GET
```ruby
res = get_japanese_tokenization_dictionary(client,'test-staging','ja_test')
pp JSON.parse res
```

# DELETE
```ruby
delete_japanese_tokenization_dictionary(client,'test-staging','ja_test')
```

# RUN
`ruby cloud_search_import_tokenize.rb`