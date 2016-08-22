class User < ApplicationRecord

    belongs_to :site

    validates :email, presence: {message: I18n.t('site.validation.email')}
    validates :password, presence: {message: I18n.t('site.validation.password')}

    after_create :generate_appkey


    private

    def generate_appkey
        self.appkey = Digest::MD5.hexdigest(email + Time.to_s).upcase
        self.save
    end

end
