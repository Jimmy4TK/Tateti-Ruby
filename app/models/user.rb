class User < ApplicationRecord
    has_secure_password
    enum state: {offline: 0,afk:1, inqueue: 2, ingame: 3}

    #Validates
    validates :name, presence: true
    validates :password_digest, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :token, uniqueness: true
    #Callbacks
    before_create :set_token

    #Methods
    def set_token
        self.token = SecureRandom.uuid
    end

end
