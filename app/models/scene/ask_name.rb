class Scene::AskName < Scene
  self.need_input = true

  def handle_input(player, text)
    player.update(name: text.strip)

    main_phase_finish(player)
  end
end
