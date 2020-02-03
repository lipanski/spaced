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
