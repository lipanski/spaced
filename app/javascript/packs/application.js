/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

require("@rails/ujs").start()
require("turbolinks").start()

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

  (document.querySelectorAll("a[data-answer-for-question]") || []).forEach(function(item) {
    item.addEventListener("click", function(event) {
      event.preventDefault();
      var question = item.getAttribute("data-answer-for-question");
      var answer = document.getElementById("answer_" + question);
      if (answer) {
        answer.classList.remove("is-hidden");
        item.classList.add("is-hidden");

        document.getElementById("disabled_links_" + question).classList.add("is-hidden");
        document.getElementById("enabled_links_" + question).classList.remove("is-hidden");
      }
    });
  });
});
