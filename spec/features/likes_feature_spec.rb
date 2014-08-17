require 'rails_helper'
require 'launchy'

describe 'liking posts' do
	before do
		alex = User.create email: "alex@alex.com", password: '12345678', password_confirmation: '12345678'
		alex.posts.create title: 'cool', body: 'cool post'
	end

	it 'is initially 0 likes' do
		visit '/posts'
		expect(page).to have_link '❤ 0'
	end

	it 'can be liked, incrementing the likes count', js: true do
		visit '/posts'
		click_link '❤ 0'
		expect(page).to have_link '❤ 1'
	end

	it 'can only be liked once per user', js: true do
		visit '/posts'
		click_link '❤ 0'
		sleep 2
		click_link '❤ 1'
		sleep 2
		expect(page).to have_link '❤ 1'
	end
end