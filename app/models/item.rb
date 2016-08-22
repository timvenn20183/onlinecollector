class Item < ApplicationRecord

    has_paper_trail

    extend FriendlyId

    belongs_to :site, required: true
    has_many :itemfields, through: :fieldoptions
    has_and_belongs_to_many :fieldoptions

    friendly_id :name, use: :slugged

    validates :name, presence: {message: I18n.t('item.validation.name')}

    before_validation :set_defaults, prepend: true

    public

    private

    def set_defaults
      self.alphabet_letter = self.name[0].upcase
       self.slug = nil
    end

end
