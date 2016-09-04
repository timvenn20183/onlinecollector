class Fieldoption < ApplicationRecord

    has_paper_trail

    extend FriendlyId

    belongs_to :site, required: true
    belongs_to :itemfield, required: true
    has_and_belongs_to_many :items

    friendly_id :name, use: :scoped, scope: :site_id

    validates :name, presence: {message: I18n.t('fieldoption.validation.name')}
    validates :name, uniqueness: {scope: [:site_id, :itemfield_id]}

    before_validation :set_defaults, prepend: true

    public

    def self.create_from_string(fieldoptions_string,itemfield)
      fieldoptions = Array.new
      fieldoptions_string.split(",").each do |fieldoption|
        fieldoptions << Fieldoption.find_or_create_by(name: fieldoption, itemfield: itemfield, site: itemfield.site)
      end
      return fieldoptions
    end

    private

    def set_defaults
      self.slug = nil
    end

end
