def Line.client
  Line::Bot::Client.new(
    channel_id: InstanceConfig.line_channel_id,
    channel_secret: InstanceConfig.line_channel_secret,
    channel_token: InstanceConfig.line_channel_token
  )
end
