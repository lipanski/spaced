//= require rails-ujs
//= require turbolinks
//= require_tree .

Turbolinks.start();

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
