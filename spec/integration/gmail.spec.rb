require 'spec_helper'
require 'rails_helper'

feature "Gmail" do
let!(:alice) { Factory(:confirmed_user) }
let!(:me) { Factory(:confirmed_user,
:email => "osalexey@yandex.ru") }
let!(:project) { Factory(:project) }
let!(:ticket) do
Factory(:ticket, :project => project,
:user => me)
define_permission!(alice, "view", project)
define_permission!(me, "view", project)
end
before do
ActionMailer::Base.delivery_method = :smtp
end
after do
ActionMailer::Base.delivery_method = :test
end
end
