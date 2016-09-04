class User < ApplicationRecord

    belongs_to :site

    validates :email, presence: {message: I18n.t('user.validation.email')}
    validates :password, presence: {message: I18n.t('user.validation.password')}
    validates :email, uniqueness: {message: I18n.t('user.validation.emailexists')}
    validate :password_complexity
    validate :check_email

    after_create :generate_appkey

    private

    def generate_appkey
        self.appkey = Digest::MD5.hexdigest(email + Time.to_s).upcase
        self.save
    end

    def password_complexity
        errors.add(:password, message: I18n.t('user.validation.password_issue')) if decrypt(self.password).length < 6
    end

    def check_email
        domain = Mail::Address.new(self.email).domain
        errors.add(:email, message: I18n.t('user.validation.email')) if domain == nil
        if domain != nil
            domain_exists = false
            begin
                domain_exists = !Whois.whois(domain).available?
            rescue
            end
            errors.add(:email, message: I18n.t('user.validation.email')) if domain_exists == false
        end

    end

end
