$(function() {
  $('input.date').datepicker({autoclose: true, todayHighlight: true, format: "dd/mm/yyyy", language: "pt-BR"});
  $('input.time-mask').inputmask('h:s', {placeholder: 'hh:mm'});
});
