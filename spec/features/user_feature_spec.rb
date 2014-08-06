require 'rails_helper'

describe 'user registration/login' do
	it 'can sign up' do
		visit '/users/sign_up'
		within '.new_user' do 
			fill_in 'Email', with: 'test@test.com'
			fill_in 'Password', with: '12345678'
			fill_in 'Password confirmation', with: '12345678'
			click_button 'Sign up'
		end
		expect(page).to have_content 'Welcome test@test.com'
	end

	it 'can sign in' do
		User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
		visit '/users/sign_in'
		within '.new_user' do 
			fill_in 'Email', with: 'test@test.com'
			fill_in 'Password', with: '12345678'
			click_button 'Sign in'
		end
		expect(page).to have_content 'Welcome test@test.com'
	end

	it 'can log out' do
		User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
		visit '/users/sign_in'
		within '.new_user' do 
			fill_in 'Email', with: 'test@test.com'
			fill_in 'Password', with: '12345678'
			click_button 'Sign in'
		end
		click_link 'Sign out'
		expect(page).to have_content 'Sign in'
		expect(current_path).to eq '/'
	end
end

describe 'adding posts' do
	before do
		alex = User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
		login_as alex
	end

	it 'user adds posts' do
		visit '/posts/new'
		fill_in 'Title', with: 'New post'
		fill_in 'Body', with: 'Body'
		attach_file 'Image', Rails.root.join('spec/images/parrot.jpeg')
		click_button 'Post'
		expect(page).to have_content 'Posted by: test@test.com'
	end
end