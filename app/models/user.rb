class User < ActiveRecord::Base
	# devise :database_authenticatable, :registerable, :confirmable,
 #    :recoverable, :rememberable, :trackable, :validatable,
 #    :token_authenticatable
    
	before_save :ensure_authentication_token
	has_secure_password
	has_many :permissions
	validates :email, presence: true
	
	def to_s
		"#{email} (#{admin? ? "Admin" : "User"})"
    end
    
end
