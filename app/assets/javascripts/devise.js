//= require admin/modernizr
//= require admin/fastclick
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require admin/bootstrap.min
//= require admin/animo
//= require admin/pages

$('#has_coupon_code_checkbox').bind('change', function(){
  if ($('#has_coupon_code_checkbox').is(':checked')) {
    $('#has_coupon_code_container').show();
  } else {
    $('#has_coupon_code_container').hide();
    $('#data_stripe_coupon').val('');
  }
});
