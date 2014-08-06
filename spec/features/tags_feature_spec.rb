describe 'Tagging posts' do
	context 'logged in' do
		before(:each) do
		user = User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
		login_as user
		end

		it 'adds posts to homepage' do
			visit '/posts/new'
			fill_in 'Title', with: 'The supercool post title!'
			fill_in 'Body', with: 'The supercool post description!'
			fill_in 'Tags', with: '#yolo, #swag'
			click_button 'Post'
			expect(page).to have_content '#yolo'
			expect(page).to have_content '#swag'
		end
	end
end