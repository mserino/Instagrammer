require 'rails_helper'

describe 'posts' do
	context 'no posts' do
		it 'displays a prompt to create posts' do
			visit '/posts'
			expect(page).to have_content 'No posts yet'
			expect(page).to have_link 'New post'
		end
	end

	context 'with posts' do
		before {Post.create title: 'New post', body: 'This is my first post'}

		it 'displays the post' do
			visit '/posts'
			expect(page).to have_content 'New post'
			expect(page).to have_content 'This is my first post'
		end
	end
end

describe 'creating posts' do
	context 'when logged in' do

		before do
			alex = User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
			login_as alex
		end
		
		it 'clicks the link' do
			visit '/posts'
			click_link 'New post'
			expect(current_path).to eq new_post_path
		end

		it 'adds the post to the homepage' do
			visit '/posts/new'
			fill_in 'Title', with: 'The supercool post title!'
			fill_in 'Body', with: 'The supercool post description!'
			click_button 'Post'
			expect(current_path).to eq posts_path
			expect(page).to have_content 'The supercool post title!'
			expect(page).to have_content 'The supercool post description!'
		end

		it 'can add a photo to the post' do
			visit '/posts/new'
			fill_in 'Title', with: 'New post'
			fill_in 'Body', with: 'Body'
			attach_file 'Image', Rails.root.join('spec/images/parrot.jpeg')
			click_button 'Post'
			expect(current_path).to eq posts_path
			expect(page).to have_css 'img.uploaded-pic'
		end

		it 'doesnt show any image if there is no file attached' do
			visit '/posts/new'
			fill_in 'Title', with: 'New post'
			fill_in 'Body', with: 'Body'
			click_button 'Post'
			expect(page).not_to have_css 'img.uploaded-pic'
		end
	end

	context 'when logged out' do
		it 'is impossible' do
			visit '/posts'
			click_link 'New post'
			expect(page).to have_content 'Sign in'
			expect(page).not_to have_field 'Title'
		end
	end
end