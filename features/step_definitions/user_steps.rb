require 'uri'
require 'cgi'

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)
	


Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end


Given /^(?:|I )can see "([^"]*)"$/ do |words|
  if page.respond_to? :should
    page.should have_content(words)
  else
    assert page.has_content?(text)
  end
end



When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end


Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path

  login = false
  if page_name.include? "login"
  	login = true
  end

  if login
  	text = page_name.split(" ")
  	third_party = text[1].strip
  	if current_path.respond_to? :should
      current_url.should include(third_party)
  	else
      assert (current_path.include?(third_party), "Not on correct login page.")
    end
  else
    if current_path.respond_to? :should
	  current_path.should == path_to(page_name)
	else
	  assert_equal path_to(page_name), current_path
	end
  end
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end