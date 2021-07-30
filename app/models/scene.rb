class Scene < ApplicationRecord
  has_many :current_players, class_name: "Player", foreign_key: "current_scene_id", dependent: :nullify

  class << self
    attr_accessor :need_input
  end

  self.need_input = false

  include Messageable

  accepts_nested_attributes_for :messages, allow_destroy: true

  default_scope ->{ order(order: :asc) }

  before_save :fill_order
  after_save :normalize_order

  def fill_order
    self.order = Scene.count + 1 if order == 0
  end

  def handle_input(text); end

  def normalize_order
    return unless Scene.where.not(id: self).find_by(order: self.order)

    Scene.where.not(id: self).where('"order" >= ?', order).update_all('"order" = "order" + 1')
  end

  def start(player)
    send_messages(player)
  end

  def send_messages(player, phase: "main", extra_delay: 0)
    raise "Currentlly only line supported" unless player.line_uid?

    messages_to_send = messages.where(phase: phase)
    delay = (messages_to_send[0]&.delay&.floor || 0) + extra_delay

    Line::SendJob.set(wait: delay).perform_later(
      player: player,
      scene: self,
      phase: phase,
      messages: messages_to_send.to_a
    )
  end

  def main_phase_finish(player, **kwargs)
    send_messages(player, phase: "after", **kwargs)
  end
end
