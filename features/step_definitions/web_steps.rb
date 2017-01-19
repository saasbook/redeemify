require 'uri'
require 'cgi'

require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "omniauth"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given /^(?:|I )am on (.+)$/ do |page_name|
    visit path_to(page_name)
end

Then /^(?:|I )should see "([^"]*)"$/ do |words|
    page.should have_content(words)
end

And /^(?:|I )should not see "([^"]*)"$/ do |words|
    page.should_not have_content(words)
end

When /^(?:|I )click on "([^"]*)" button$/ do |button|
  click_button(button)
end

Then /^(?:|I )should be on (.*)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.should == path_to(page_name)
end

When /^(?:|I )fill in "(.*)" with "(.*)"$/ do |field, value|
  fill_in(field, :with => value)
end
