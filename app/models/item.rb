class Item < ApplicationRecord

    has_paper_trail

    extend FriendlyId

    belongs_to :site, required: true
    has_many :itemfields, through: :fieldoptions
    has_and_belongs_to_many :fieldoptions

    friendly_id :name, use: :scoped, scope: :site_id

    validates :name, presence: {message: I18n.t('item.validation.name')}

    before_validation :set_defaults, prepend: true
    after_create :set_collectionid

    public

    private

    def set_defaults
        self.alphabet_letter = self.name[0].upcase if !self.name.blank?
        self.slug = nil
    end

    def set_collectionid
        self.collectionid = self.id if self.collectionid.blank?
        self.save
    end
end
