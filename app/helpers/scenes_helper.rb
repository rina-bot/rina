module ScenesHelper
  def scene_type_options
    [
      ["單向發言", "Scene"],
      ["詢問暱稱", "Scene::AskName"],
      ["等待關鍵字", "Scene::WaitFlag"],
      ["請求遠端工作", "Scene::EnqueueRemoteJob"],
      ["等待遠端工作完成", "Scene::WaitRemoteJob"]
    ]
  end

  def phase_messages(scene, phase)
    new_message = scene.messages.build(phase: phase)
    scene.messages.where(phase: phase) + [new_message]
  end
end
