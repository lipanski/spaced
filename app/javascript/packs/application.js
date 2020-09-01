/* eslint no-console:0 */

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

require("@rails/ujs").start()
require("turbolinks").start()

import { Application } from "stimulus"
import TodayController from "../controllers/today_controller"

const application = Application.start()
application.register("today", TodayController)

document.addEventListener("turbolinks:load", function() {
  (document.querySelectorAll(".notification .delete") || []).forEach(function(item) {
    var notification = item.parentNode;

    item.addEventListener("click", function() {
      notification.parentNode.removeChild(notification);
    });
  });

  // Enable the hamburger button on mobile resolutions
  if ( document.querySelectorAll(".navbar-burger") ) {
    var navbarBurgers = Array.prototype.slice.call(document.querySelectorAll(".navbar-burger"), 0);

    if (navbarBurgers.length > 0) {
      navbarBurgers.forEach(function (element) {
        element.addEventListener("click", function () {
          var target = document.getElementById(element.dataset.target);

          element.classList.toggle("is-active");
          target.classList.toggle("is-active");
        });
      });
    }
  }
});
