# frozen_string_literal: true

#
# Author:: Chef Partner Engineering (<partnereng@chef.io>)
# Copyright:: Copyright (c) 2015 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/knife'
require 'chef/knife/cloud/server/delete_options'
require 'chef/knife/cloud/server/delete_command'
require 'chef/knife/cloud/oraclecloud_service'
require 'chef/knife/cloud/oraclecloud_service_helpers'
require 'chef/knife/cloud/oraclecloud_service_options'

class Chef
  class Knife
    class Cloud
      class OraclecloudServerDelete < ServerDeleteCommand
        include ServerDeleteOptions
        include OraclecloudServiceHelpers
        include OraclecloudServiceOptions

        banner 'knife oraclecloud server delete INSTANCE_ID [INSTANCE_ID] (options)'

        # overriding this method from knife-cloud so we can pull the instance label
        # to pass to delete_from_chef rather than the resource ID
        def execute_command
          @name_args.each do |instance_id|
            instance = service.get_server(instance_id)
            service.delete_server(instance_id)
            delete_from_chef(instance.label)
          end
        end
      end
    end
  end
end
