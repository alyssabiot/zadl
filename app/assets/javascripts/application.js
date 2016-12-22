//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment
//= require moment/fr
//= require bootstrap-datetimepicker
//= require underscore
//= require gmaps/google
//= require typed
//= require clipboard
//= require data-confirm-modal
//= require_tree ./vendor/
//= require_tree .

// alert('Sadly ...');

$(function () {
  $('input.datetimepicker').datetimepicker({
    format: 'DD-MM-YYYY HH:mm',
    locale: 'fr',
    sideBySide: true,
    stepping: 15,
    showClose: true,
    toolbarPlacement: 'bottom',
    icons: {
      close: 'glyphicon glyphicon-check'
    }
  });
});

dataConfirmModal.setDefaults({
    title: "Annulation d'activité"
});


