HipChat Webistrano
================

A Ruby On Rails plugin for [Webistrano](https://github.com/peritor/webistrano) to send deployment notifications to [HipChat](https://www.hipchat.com/) rooms

Adapted heavily from https://github.com/caiosba/slack-webistrano

# Setup
* Obtain HipChat namespace 
* Create anew HipChat room
* Generate HipChat API token with notification type
* On Webistrano, copy this plugin to `vendor/plugins/` and add the following to `config/webistrano_config.rb`:

  ```ruby
    # HipChat integration
    :hipchat_settings => {
      :webistrano_host => 'http://webistrano.example.com',
      :token => 'hipchat_token',
      :from => 'Webistrano',
      # If a project is not present on the hash "rooms" below, the notifications will go to the default room
      :default_room => 'hipchat_room_name_OR_id',
      :channels => {
        'Webistrano Project Name' => '#slack_channel_name',
        # Mapping a project to an empty string will disable notifications for this project 
        'Project that you do not want notifications' => ''
      }   
    }
  ```

  on some Webistrano forks configuration file could have other name (`config/webistrano.rb`) and syntax
  ```ruby
    # HipChat integration
    :hipchat_settings:
      :webistrano_host: 'http://webistrano.example.com'
      :token: 'hipchat_token'
      :from: 'Webistrano'
      # If a project is not present on the hash "rooms" below, the notifications will go to the default room
      :default_room: 'hipchat_room_name_OR_id'
      :rooms: {
        'Webistrano Project Name': 'hipchat_room_name_OR_id',
        # Mapping a project to an empty string will disable notifications for this project
        'Project that you do not want notifications': ''
      }  
    }
  ```
* Install `hipchat` gem
* Restart the Rails server
