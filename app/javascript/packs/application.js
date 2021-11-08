// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require popper
//= require bootstrap-sprockets
//= require bootstrap
//= require jquery
//= require moment
//= require daterangepicker
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "bootstrap"
import "jquery"
import "channels"
import "@hotwired/turbo-rails"


import "./sb-admin-2.min"
import "./sb-admin-2"
import "./bootstrap-bundle/bootstrap.bundle.min"
import "./jquery-easing/jquery.easing.min"

import "./stylesheets/fontawesome/css/all.min.css"
import "./stylesheets/sb-admin-2.min.css"
import "./stylesheets/application.scss"
// import "./chart.min"
// import "./Chart.bundle.min"
// import "./demo/chart-area-demo"
// import "./demo/chart-pie-demo"

import "controllers"

global.toastr = require("toastr")
Rails.start()
ActiveStorage.start()

$(document).on('click', '.close', function () {
    $(this).parent().hide();
});
