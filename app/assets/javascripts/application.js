//= require rails-ujs
//= require turbolinks
//= require_tree .

Turbolinks.start();

document.addEventListener('turbolinks:load', function() {
  (document.querySelectorAll('.notification .delete') || []).forEach(function(item) {
    var notification = item.parentNode;

    item.addEventListener('click', function() {
      notification.parentNode.removeChild(notification);
    });
  });
});
