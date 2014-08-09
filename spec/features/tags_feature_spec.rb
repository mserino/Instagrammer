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

	context 'existing posts' do 

		before do
			user = User.create email: 'alex@example.com', password: '12345678', password_confirmation: '12345678'
			user.posts.create title: 'Post1', tag_names: 'yolo'
			user.posts.create title: 'Post2', tag_names: 'swag'
			visit '/posts'
		end

		it 'should filter posts by selected tag' do
			click_link 'yolo'
			expect(page).to have_content 'Post1'
			expect(page).not_to have_content 'Post2'
		end

		it 'uses the tag name in the url' do
			click_link 'yolo'
			expect(current_path).to eq '/tags/yolo'
		end
	end
end