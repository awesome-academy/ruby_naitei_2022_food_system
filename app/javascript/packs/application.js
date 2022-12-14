// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import 'channels'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("jquery")
import "bootstrap"
global.toastr = require("toastr");
toastr.options = {
  closeButton: false,
  debug: false,
  newestOnTop: false,
  progressBar: true,
  positionClass: "toast-top-right",
  preventDuplicates: false,
  onclick: null,
  showDuration: "300",
  hideDuration: "1000",
  timeOut: "3000",
  extendedTimeOut: "1000",
  showEasing: "swing",
  hideEasing: "linear",
  showMethod: "fadeIn",
  hideMethod: "fadeOut",
};

require("js/customer/jquery-1.12.4.minb8ff")
require("js/customer/jquery-ui-1.12.4.minb8ff")
require("js/customer/bootstrap.min")
require("js/customer/jquery.flexslider")
require("js/customer/chosen.jquery.min")
require("js/customer/owl.carousel.min")
require("js/customer/jquery.countdown.min")
require("js/customer/jquery.sticky")
require("js/customer/functions")
require("js/customer/cart");
