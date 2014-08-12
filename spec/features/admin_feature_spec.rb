require 'rails_helper'

describe 'admins' do
	it 'cannot sign up' do
		# visit '/admins/sign_up'
		# expect(page).not_to have_content 'Sign up'
		expect{visit '/admins/sign_up'}.to raise_error
	end
end