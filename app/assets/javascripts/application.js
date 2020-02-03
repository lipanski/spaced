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

  (document.querySelectorAll("a[data-show-answer]") || []).forEach(function(item) {
    item.addEventListener("click", function(event) {
      event.preventDefault();
      var answer = document.getElementById(item.getAttribute("data-show-answer"));
      if (answer) {
        answer.classList.remove("is-hidden");
        item.classList.add("is-hidden");
      }
    });
  });
});
