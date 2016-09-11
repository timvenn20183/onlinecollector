class Item < ApplicationRecord

    has_paper_trail

    extend FriendlyId

    serialize :prefs, Hash

    belongs_to :site, required: true
    has_many :itemfields, through: :fieldoptions
    has_and_belongs_to_many :fieldoptions
    has_many :imagefiles

    friendly_id :name, use: :scoped, scope: :site_id

    validates :name, presence: {message: I18n.t('item.validation.name')}

    before_validation :set_defaults, prepend: true
    after_create :set_collectionid
    before_save :set_searchstring

    public

    def check_default_image
        self.prefs[:default_image] = nil if self.site.imagefiles.find_by_slug(self.prefs[:default_image]).blank?
        self.prefs[:default_image] = nil if self.imagefiles.blank?
        self.prefs[:default_image] = self.imagefiles.first.slug if self.prefs[:default_image] == nil and !self.imagefiles.blank?
        self.save
    end

    private

    def set_defaults
        self.alphabet_letter = self.name[0].upcase if !self.name.blank?
        self.slug = nil
    end

    def set_collectionid
        self.collectionid = self.id if self.collectionid.blank?
        self.save
    end

    def set_searchstring
        value = self.name
        value += " " + self.collectionid if !self.collectionid.blank?
        value += " " + self.note if !self.note.blank?
        value += " " + self.acquired_date.to_s if !self.acquired_date.blank?
        self.fieldoptions.each do |fo|
            value += " " + fo.name
        end
        self.searchstring = value
    end
end
