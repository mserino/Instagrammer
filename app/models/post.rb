class Post < ActiveRecord::Base
	has_attached_file :image,
	                  styles: { thumb: '300x300>' },
                    storage: :s3,
    								s3_credentials: {
							      bucket: 'instagrammer_may',
							      access_key_id: Rails.application.secrets.s3_access_key,
							      secret_access_key: Rails.application.secrets.s3_secret_key
    }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :likes

  def tag_names
    ''
  end

  def tag_names=(tag_list)
  	# self.tags << Tag.create(name: tag_list)
    tag_list.split(/\s,?/).each do |tag|
      tags << Tag.find_or_create_by(name: tag)
    end
  end
end
