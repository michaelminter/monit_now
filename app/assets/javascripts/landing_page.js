// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require admin/modernizr
//= require admin/fastclick
//= require jquery
//= require jquery_ujs
//= require turbolinks
// require_tree .
//= require admin/bootstrap.min
//= require admin/animo
//= require admin/pages

// On window load. This waits until images have loaded which is essential
$(window).load(function(){

  // Fade in images so there isn't a color "pop" document load and then on window load
  $('.grayscale').fadeIn(500);

  // clone image
  $('.grayscale').each(function(){
    var el = $(this);
    el.css({"position":"absolute"}).wrap("<div class='img_wrapper' style='display: inline-block'>").clone().addClass('img_grayscale').css({"position":"absolute","z-index":"998","opacity":"0"}).insertBefore(el).queue(function(){
      var el = $(this);
      el.parent().css({"width":this.width,"height":this.height});
      el.dequeue();
    });
    this.src = grayscale(this.src);
  });

  // Fade image
  $('.grayscale').mouseover(function(){
    $(this).parent().find('img:first').stop().animate({opacity:1}, 1000);
  })
  $('.img_grayscale').mouseout(function(){
    $(this).stop().animate({opacity:0}, 1000);
  });
});

// Grayscale w canvas method
function grayscale(src){
  var canvas = document.createElement('canvas');
  var ctx = canvas.getContext('2d');
  var imgObj = new Image();
  imgObj.src = src;
  canvas.width = imgObj.width;
  canvas.height = imgObj.height;
  ctx.drawImage(imgObj, 0, 0);
  var imgPixels = ctx.getImageData(0, 0, canvas.width, canvas.height);
  for(var y = 0; y < imgPixels.height; y++){
    for(var x = 0; x < imgPixels.width; x++){
      var i = (y * 4) * imgPixels.width + x * 4;
      var avg = (imgPixels.data[i] + imgPixels.data[i + 1] + imgPixels.data[i + 2]) / 3;
      imgPixels.data[i] = avg;
      imgPixels.data[i + 1] = avg;
      imgPixels.data[i + 2] = avg;
    }
  }
  ctx.putImageData(imgPixels, 0, 0, 0, 0, imgPixels.width, imgPixels.height);
  return canvas.toDataURL();
}
