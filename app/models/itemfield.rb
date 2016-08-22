class Itemfield < ApplicationRecord

    has_paper_trail

    extend FriendlyId

    belongs_to :site, required: true
    has_many :fieldoptions, dependent: :destroy
    has_many :items, through: :fieldoptions

    friendly_id :name, use: :slugged

    validates :name, presence: {message: I18n.t('itemfield.validation.name')}
    validates :name, uniqueness: {scope: :site_id}

    before_validation :set_defaults, prepend: true

    public

    def self.create_defaults(site)
      I18n.t('itemfield.required_itemfield_list').split(",").each do |i|
        Itemfield.create(name: i.strip.titleize, site: site)
      end
    end

    def self.create_from_string(itemfields_string,site)
      itemfields = Array.new
      itemfields_string.split(",").each do |itemfield|
        itemfields << Itemfield.find_or_create_by(name: itemfield, site: site)
      end
      return itemfields
    end

    private

    def set_defaults
      self.slug = nil
    end

end
