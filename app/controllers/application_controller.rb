class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :general_initilization

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
        },{
            text: 'Vendors',
            key: 'vendors',
            iconClass: 'fa-users'
        },{
            text: 'Invoices',
            key: 'invoices',
            iconClass: 'fa-newspaper'
        }]
    end
end
