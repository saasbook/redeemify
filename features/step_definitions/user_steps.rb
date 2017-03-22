When /^(?:|I am )logging in through OAuth as a user$/ do
  set_omniauth()
  click_link('google-auth')
end

Given /^(?:|I have )signed in through OAuth as a(?:| registered) user$/ do
  p = Provider.create(name: 'Amazon', provider: 'amazon', 
        email: 'test@amazon.com')
  p.redeemifyCodes.create(code: '12345')
  set_omniauth()
  visit(root_path)
  click_link('google-auth')
  fill_in("code", with: '12345')
  click_button('submit')
end

And /^(?:|I )should see option to delete account$/ do
  page.should have_content('Delete your account')
end

When /^(?:|I )delete account$/ do
  click_link('delete-account')
  expect(page).to have_current_path('/sessions/delete_page')
  click_link('delete-confirm')
end

And /^(?:|I )should see message about successful account deletion$/ do
  page.should have_content('Your account has been deleted')
end

And /^(?:|I )should not have a possibility to log in with the same redeemify code$/ do
  set_omniauth()
  click_link('google-auth')
  page.should have_content('Redeem your code!')
  fill_in('code', with: '12345')
  click_button('submit')
  page.should have_content('Your code is either invalid or has been redeemed already')
end