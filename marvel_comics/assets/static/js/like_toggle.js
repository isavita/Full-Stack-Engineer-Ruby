$(document).ready(function() {

  var likeToggle = function(element, url, on_success) {
    var csrf = $("meta[name=csrf]").attr("content");
    var comicsId = element.data("comicsId");
    var userId = 1; // Usually current user

    $.ajax({
      url: url,
      type: "POST",
      data: {
        like: {
          likable_id: comicsId,
          likable_type: "comics",
          liker_id: userId,
          liker_type: "user"
        }
      },
      dataType: "json",
      headers: {
        "X-CSRF-TOKEN": csrf
      },
      success: function(_data) {
        on_success(element);
      }
    });
  };

  $(".comics-cover").on("click", function(ev) {
    ev.preventDefault();
    var element = $(this);

    if (element.hasClass("liked")) {
      var on_success = function(element) { element.removeClass("liked"); };
      likeToggle(element, "/like/remove", on_success);
    } else {
      var on_success = function(element) { element.addClass("liked"); };
      likeToggle(element, "/like", on_success);
    };
  });

});
