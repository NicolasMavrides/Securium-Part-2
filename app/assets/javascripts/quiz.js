$(document).ready(function() {
  $("form").submit(function(e){
    checked_radio = $("input[type=radio]:checked").length;
    checked_checkbox = $("input[type=checkbox]:checked").length;
    if (checked_radio == 0 && checked_checkbox < 1){
      $("#error_text").removeClass("d-none");
      e.preventDefault(e);
      setTimeout(function(){
        $('input[type="submit"]').removeAttr('disabled');
  }, 100);
    }
  });
});