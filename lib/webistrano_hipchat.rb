require 'hipchat'

module WebistranoHipchat

  def self.notify(deployment, settings, message, color)

    return if (settings[:rooms][deployment.stage.project.name] === '')

    token = settings[:token]
    from = settings[:from]
    room = settings[:rooms][deployment.stage.project.name] || settings[:default_room]

    client = HipChat::Client.new(token)
    client[room].send(from, message, :message_format => 'html', :color => color)

  end

end
