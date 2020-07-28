$(function() {

  if ($('.result-item').length > 5 ) {
    $("#seeMore").show();
  }

  $('.result-item').slice(0, 5).show();

  $('#seeMore').on('click', function(e) {

    e.preventDefault();

    $('.result-item:hidden').slice(0, 5).slideDown();
    if ($('.row:hidden').length === 0) {
      $('#seeMore').fadeOut('slow');
    }

    $('html,body').animate({
      scrollTop: $(this).offset().top
    }, 1500);
  });
});
