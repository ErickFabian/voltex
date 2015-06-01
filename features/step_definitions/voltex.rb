When 'I generate a new rails application' do
  steps %{
    When I successfully run `cp -R ../../spec/dummy #{APP_NAME}`
    And I cd to "#{APP_NAME}"
    And I add to Gemfile "gem 'sqlite3'"
    And I install gems
  }
end

When /^I configure the application to use voltex$/ do
  steps %{
    And I add to Gemfile "gem 'voltex', path: '#{VOLTEX_ROOT}'"
    And I install gems
  }
end

When /^I install gems$/ do
  steps %{When I successfully run `bundle install --local`}
end

When /^I add to Gemfile "([^"]*)"$/ do |content|
  append_to_file('Gemfile', "\n" + content)
end

When /^the migration "([^"]*)" should (not )?contain:$/ do |file, expect_match, partial_content|
  file = Dir["#{APP_ROOT}/db/migrate/*#{file}"].first
  check_file_content(file, Regexp.compile(Regexp.escape(partial_content)), !expect_match)
end

When /^the model "([^"]*)" should (not )?contain:$/ do |file, expect_match, partial_content|
  file = Dir["#{APP_ROOT}/app/models/#{file}"].first
  check_file_content(file, Regexp.compile(Regexp.escape(partial_content)), !expect_match)
end

When /^I generate models named "([^\"]+)"$/ do |models|
  models.split(' ').each do |model|
    steps %{
      When I write to "#{APP_ROOT}/app/models/#{model.downcase}.rb" with:
      """
      class #{model} < ActiveRecord::Base
      end
      """
    }
  end
end
