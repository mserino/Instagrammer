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
end