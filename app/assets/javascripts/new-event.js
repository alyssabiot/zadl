$(document).ready(function() {
  $('.btn-next').on('click', function() {
    $('.form-part').addClass('hidden');
    $(this).parent().parent().next().fadeIn().removeClass('hidden')
  });

  $('.btn-return').on('click', function() {
    $('.form-part').addClass('hidden');
    $(this).parent().parent().prev().fadeIn().removeClass('hidden')
  });

});
