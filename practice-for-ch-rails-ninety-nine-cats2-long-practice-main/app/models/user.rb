class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    before_validation :ensure_session_token

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)   
        @password = password
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)

        password_object.is_password?(password)
    end

    def self.find_by_credentials(username,password)
        user = User.find_by(username: username) 

        if user.is_password?(password) && user
            user
        else
            nil
        end

    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end



    private

    def generate_unique_session_token
        SecureRandom::urlsafe_base64
    end

end
