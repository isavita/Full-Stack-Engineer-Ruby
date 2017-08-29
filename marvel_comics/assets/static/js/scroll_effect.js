$(document).ready(function() {

  $(window).on("scroll", function(ev) {
    ev.preventDefault();

    var searchBar = $(".search-bar")
    if ($(this).scrollTop() > searchBar.height()) {
      searchBar.addClass("scrolled");
    } else {
      searchBar.removeClass("scrolled");
    }
  });

});
