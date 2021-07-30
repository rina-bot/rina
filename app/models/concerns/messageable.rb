module Messageable
  extend ActiveSupport::Concern

  included do
    has_many :messages, dependent: :destroy, as: :trigger
  end

  def messages_attributes=(assigned_attributes)
    assigned_attributes.values.each do |attrs|
      next if attrs["file"] || attrs["flag"] == "1" || attrs["_destroy"] == "1" || attrs["id"]
      next if attrs["grant_achievement_ids"]&.any?(&:present?)

      attrs["_destroy"] = attrs["text"].blank?
    end

    super(assigned_attributes)
  end
end
