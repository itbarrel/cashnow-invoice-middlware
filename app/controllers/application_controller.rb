# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :general_initilization

  def after_sign_in_path_for(_resource)
    root_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end

  def general_initilization
    @side_menu_items = [{
      text: 'Dashboard',
      link: '/',
      key: '',
      iconClass: 'fa-tachometer-alt'
    },
                        {
                          text: 'Clients',
                          link: '/clients',
                          key: 'clients',
                          iconClass: 'fa-gavel'
                        }, {
                          text: 'Vendors',
                          key: 'vendors',
                          iconClass: 'fa-users'
                        }, {
                          text: 'Invoices',
                          key: 'documents',
                          iconClass: 'fa-newspaper'
                        }]
  end
end
