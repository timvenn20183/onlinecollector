class Site < ApplicationRecord

    has_paper_trail

    serialize :prefs, Hash

    has_many :items
    has_many :itemfields, dependent: :destroy
    has_many :fieldoptions
    has_many :users

    validates :subdomain, presence: {message: I18n.t('site.validation.subdomain.presence')}
    validates :subdomain, uniqueness: {message: I18n.t('site.validation.subdomain.uniqueness')}
    validates :title, presence: {message: I18n.t('site.validation.title')}

    before_validation :set_defaults
    after_create :create_defaults, :generate_activationkey

    public

    def full_url
        return self.subdomain + "." + Onlinecollector::Application.config.domain
    end

    private

    def set_defaults
      self.title = I18n.t('site.default.title') if self.title.blank?
    end

    def create_defaults
      Itemfield.create_defaults(self)
    end

    def generate_activationkey
        self.activationkey = Digest::MD5.hexdigest(subdomain + Time.to_s).upcase
        self.save
    end


end
