class Api::V1::ApiController < ActionController::API
    respond_to :json

    # before_action :authenticate_user!
    # before_action :general_initilization

    # def after_sign_in_path_for(resource)
    #     root_path
    # end

    # def after_sign_out_path_for(resource)
    #     new_user_session_path
    # end

    # def general_initilization
    #     @side_menu_items = [{
    #         text: 'Dashboard',
    #         link: '/',
    #         key: '',
    #         iconClass: 'fa-tachometer-alt'
    #     },
    #     {
    #         text: 'Clients',
    #         link: '/clients',
    #         key: 'clients',
    #         iconClass: 'fa-gavel'
    #     },{
    #         text: 'Vendors',
    #         key: 'vendors',
    #         iconClass: 'fa-users'
    #     },{
    #         text: 'Documents',
    #         key: 'documents',
    #         iconClass: 'fa-newspaper'
    #     }]
    # end
end
