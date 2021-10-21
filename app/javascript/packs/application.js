// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require popper
//= require bootstrap-sprockets
//= require bootstrap
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "bootstrap"
import "jquery"
import "channels"
import "@hotwired/turbo-rails"

import "./css/fontawesome/css/all.min.css"
import "./css/sb-admin-2.min.css"

import "./bootstrap-bundle/bootstrap.bundle.min"
import "./sb-admin-2.min"

import "./jquery-easing/jquery.easing.min"
import "./sb-admin-2.min"

Rails.start()
ActiveStorage.start()
