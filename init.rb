require 'webistrano_hipchat'

Deployment.class_eval do

  alias complete_with_error_original! complete_with_error!
  def complete_with_error!
    complete_with_error_original!
    color = "red"
    message = "#{self.stage.project.name} | <em>#{self.user.login}</em> did #{self.task} to #{self.stage.name} <strong>with errors</strong>! | ID #{self.id} | <a href=#{self.url}>View log</a>"
    WebistranoHipchat.notify(self, WebistranoConfig[:hipchat_settings], message, color) unless WebistranoConfig[:hipchat_settings].nil?
  end


  alias complete_successfully_original! complete_successfully!
  def complete_successfully!
    complete_successfully_original!
    color = "green"
    message = "#{self.stage.project.name} | <em>#{self.user.login}</em> did #{self.task} to #{self.stage.name} <strong>successfully</strong>! | ID #{self.id} | <a href=#{self.url}>View log</a>"
    WebistranoHipchat.notify(self, WebistranoConfig[:hipchat_settings], message, color) unless WebistranoConfig[:hipchat_settings].nil?
  end


  alias complete_canceled_original! complete_canceled!
  def complete_canceled!
    color = "yellow"
    message = "#{self.stage.project.name} | <em>#{self.user.login}</em> <strong>canceled</strong> #{self.task} to #{self.stage.name}! ID #{self.id} | <a href=#{self.url}>View log</a>"
    WebistranoHipchat.notify(self, WebistranoConfig[:hipchat_settings], message, color) unless WebistranoConfig[:hipchat_settings].nil?
    complete_canceled_original!
  end


  def url
    # FIXME: Better to try to call project_stage_deployment_path here
    path = "projects/#{self.stage.project.id}/stages/#{self.stage.id}/deployments/#{self.id}"
    URI.join WebistranoConfig[:hipchat_settings][:webistrano_host], path
  end

end




Webistrano::Deployer.class_eval do
  alias execute_original! execute!
  def execute!
    color = "purple"
    message = "#{deployment.stage.project.name} | <em>#{deployment.user.login}</em> <strong>started</strong> to #{deployment.task} to #{deployment.stage.name} | ID #{deployment.id} #{deployment.description.blank? ? '' : '"' + deployment.description + '"'} | <a href=#{deployment.url}>View log</a>"
    WebistranoHipchat.notify(deployment, WebistranoConfig[:hipchat_settings], message, color) unless WebistranoConfig[:hipchat_settings].nil?
    execute_original!
  end
end
