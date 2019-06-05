require 'active_admin'
require 'workflow'

require 'active_admin/workflow/dsl'

ActiveAdmin::DSL.send :include, ActiveAdmin::Workflow::DSL
