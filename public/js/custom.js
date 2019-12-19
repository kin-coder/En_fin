jQuery(document).ready(function(){
  'use strict';

  //============================== MENU SCROLL =========================
   $(window).load(function(){
    $('.body-wrapper').each(function(){
      var header_area = $('.header');
      var main_area = header_area.children('.navbar-default');

      var logo = main_area.find('.navbar-header');
      var navigation = main_area.find('.navbar-collapse');
      var original = {
        nav_top: navigation.css('margin-top')
      };

      $(window).scroll(function(){
        if( main_area.hasClass('bb-fixed-header') && ($(this).scrollTop() === 0 || $(this).width() < 750)){
          main_area.removeClass('bb-fixed-header').appendTo(header_area);
          navigation.animate({'margin-top': original.nav_top}, {duration: 300, queue: false, complete: function(){
            header_area.css('height', 'auto');
          }});
        }else if( !main_area.hasClass('bb-fixed-header') && $(this).width() > 750 &&
          $(this).scrollTop() > header_area.offset().top + header_area.height() - parseInt($('html').css('margin-top'), 10) ){

          header_area.css('height', header_area.height());
          main_area.css({'opacity': '0'}).addClass('bb-fixed-header');
          main_area.appendTo($('body')).animate({'opacity': 1});

          navigation.css({'margin-top': '0px'});
        }
      });
    });

    $(window).trigger('resize');
    $(window).trigger('scroll');
  });

  //============================== SELECT BOX =========================
  $('.select-drop').selectbox();

  //============================== header =========================

  $('.navbar a.dropdown-toggle').on('click', function(e) {
      var elmnt = $(this).parent().parent();
      if (!elmnt.hasClass('nav')) {
          var li = $(this).parent();
          var heightParent = parseInt(elmnt.css('height').replace('px', ''), 10) / 2;
          var widthParent = parseInt(elmnt.css('width').replace('px', ''), 10) - 10;

          if(!li.hasClass('open')) {
            li.addClass('open');
          } else {
            li.removeClass('open');
          }
          $(this).next().css('top', heightParent + 'px');
          $(this).next().css('left', widthParent + 'px');

          return false;
      }
  });

  //============================== ALL DROPDOWN ON HOVER =========================
  if($('.navbar').width() > 1007)
  {
    $('.nav .dropdown').on('mouseover', function() {
          $(this).addClass('open');
      }),
    $('.nav .dropdown').on('mouseleave', function() {
          $(this).removeClass('open');
      });
  }

  //============================== MAIN SLIDER =========================
  var $heroSlider = $( '.main-slider .inner' );
  if ( $heroSlider.length > 0 ) {
    $heroSlider.each( function () {

    var loop = $(this).parent().data('loop'),
        autoplay = $(this).parent().data('autoplay'),
        interval = $(this).parent().data('interval') || 3000;

      $(this).owlCarousel({
        items: 1,
        loop: loop,
        margin: 0,
        nav: true,
        dots: true,
        navText: [  ],
        autoplay: autoplay,
        autoplayTimeout: interval,
        autoplayHoverPause: true,
        smartSpeed:700
      });
    });
  }
  $( '.rtl .main-slider .inner' ).owlCarousel({
    rtl: true
  });
  //============================== MAIN SLIDER RESIZE =========================
  function resizeContentMobile() {
    var height = $(window).height() - 119;
    $('.slideResize').height(height);
  }
  resizeContentMobile();

  function resizeContent() {
    var height = $(window).height() - 159;
    $('.slideResize').height(height);
  }
  resizeContent();

  if ($(window).width() < 768) {
    resizeContentMobile();
  }
  else {
    resizeContent();
  }

  $(window).resize(function() {
    resizeContent();
    resizeContentMobile();
  });

  //============================== OWL-CAROUSEL =========================
  var owl = $('.owl-carousel.partnersLogoSlider');
    owl.owlCarousel({
      loop:true,
      margin:28,
      autoplay:true,
      autoplayTimeout:6000,
      autoplayHoverPause:true,
      nav:true,
      dots: false,
      smartSpeed:500,
      responsive:{
        320:{
          slideBy: 1,
          items:1
        },
        768:{
          slideBy: 1,
          items:3
        },
        992:{
          slideBy: 1,
          items:4
        }
      }
    });

    $('.owl-carousel.partnersLogoSlider').owlCarousel({
      rtl: true
    });

  //============================== EXPERT SLIDER =========================
  $('#myCarousel').carousel({
    interval: 3000,
     cycle: true
   });

   //============================== BACK TO TOP =========================
   $(window).scroll(function(){
     if ($(this).scrollTop() > 10) {
       $('.backToTop').css('opacity', 1);
     } else {
       $('.backToTop').css('opacity', 0);
     }
   });

   //============================== BACK TO TOP SMOOTH SCROLL=========================
  $('a[href="#pageTop"]').on('click', function (e) {
    e.preventDefault();
    e.stopPropagation();
    $('html, body').animate({ scrollTop: 0 }, 1500);
      return false;
  });

  //============================== SMOOTH SCROLLING TO SECTION =========================
  $('.scrolling  a[href*="#"]').on('click', function (e) {
    e.preventDefault();
    e.stopPropagation();
    var target = $(this).attr('href');
    $(target).velocity('scroll', {
      duration: 800,
      offset: -150,
      easing: 'easeOutExpo',
      mobileHA: false
    });
  });

  //============================== DATE-PICKER =========================
  $('.datepicker').datepicker({
    startDate: 'dateToday',
    autoclose: true
  });

  //============================== COUNT DOWN =========================
  $('#simple_timer').syotimer({
    year: 2018,
    month: 5,
    day: 9,
    hour: 20,
    minute: 30
  });

  //============================== PRICE RANGER SLIDER =========================
  var minimum = 12;
  var maximum = 300;
  var priceMin = $( '#price-amount-1' );
  var priceMax = $( '#price-amount-2' );

  $( '#price-range' ).slider({
    range: true,
    min: minimum,
    max: maximum,
    values: [ minimum, maximum ],
    slide: function( event, ui ) {
      priceMin.val( '$' + ui.values[ 0 ] );
      priceMax.val( '$' + ui.values[ 1 ] );
    }
  });

  priceMin.val( '$' + $( '#price-range' ).slider( 'values', 0 ));
  priceMax.val( '$' + $( '#price-range' ).slider( 'values', 1 ));


  //============================== BOOTSTRAP CAROUSEL SWIEP =========================
  $('#productSlider, #thubmnailTeamSlider').on('touchstart', function(event){
      var xClick = event.originalEvent.touches[0].pageX;
      $(this).one('touchmove', function(event){
          var xMove = event.originalEvent.touches[0].pageX;
          if( Math.floor(xClick - xMove) < -5 ){
              $('#productSlider, #thubmnailTeamSlider').carousel('prev');
          }
          else if( Math.floor(xClick - xMove) > 5 ){
              $('#productSlider, #thubmnailTeamSlider').carousel('next');
          }
      });
      $('.carousel').on('touchend', function(){
              $(this).off('touchmove');
      });
  });

  //============================== BOOTSTRAP THUMBNAIL SLIDER =========================
  $('#thubmnailTeamSlider').carousel({
    interval: 3000
  });

  $('#thubmnailTeamSlider .item').each(function(){
      var itemToClone = $(this);
      for (var i=1;i<4;i++) {
        itemToClone = itemToClone.next();

          if (!itemToClone.length) {
              itemToClone = $(this).siblings(':first');
            }

        itemToClone.children(':first-child').clone()
        .addClass('cloneditem-'+(i))
        .appendTo($(this));
      }
  });

  //============================== SINGLE SERVICE LEFT TAB =========================
  $('#singleServiceTab a').on('click', function (e) {
    e.preventDefault();
    $(this).tab('show');
    $('.nav-stacked li a i').addClass('fa-angle-down').removeClass('fa-angle-up');
    $(this).find('i').toggleClass('fa-angle-up fa-angle-down');
  });

  $('.nav-stacked li a').on('click', function() {
    $('.tabList').removeClass('active openTab');
    $(this).parent('.tabList').addClass('active openTab');
  });

  $('.nav-stacked li .dropdown-menu li a').on('click', function (e) {
    $('.tabList').removeClass('active openTab');
    $(this).closest('.nav-stacked li.tabList').addClass('active openTab');
  });

  //============================== ACCRODION =========================
  $('.content-collapse li').on('click', function () {
      $(this).toggleClass('active').siblings().removeClass('active');
  });

});
// =========================== Contact Form =========================
$('#angelContactForm').submit(function(e){
  var contactdata  =  $(this).serializeArray();
  var submiturl    =  $(this).attr('action');
  var submitbtn 	 =  $('#contact-submit-btn');
  submitbtn.val('Sending...');
  $('#angelContactForm :input').prop('disabled', true);
  $.ajax({
    url: submiturl,
    type: 'POST',
    dataType: 'json',
    data : contactdata,
    success: function(response){
      $('#alert').removeClass('alert alert-success');
      $('#alert').removeClass('alert alert-danger');
      if(response.status=== 'true'){
        $('#alert').addClass('alert alert-success');
        $('#angelContactForm :input').prop('disabled', false);
        $('#angelContactForm')[0].reset();
        submitbtn.val('Send');
      }else{
        $('#alert').addClass('alert alert-danger');
        $('#angelContactForm :input').prop('disabled', false);
        submitbtn.val('Send');
      }
      $('#alert').html(response.message).slideDown();
      window.setTimeout(function() {
        $('#alert').alert('close'); }, 3000);
      }
    });
    e.preventDefault();
  });

  // =========================== Contact Form =========================
  $('#angelContactForm').submit(function(e){
    var contactdata  =  $(this).serializeArray();
    var submiturl    =  $(this).attr('action');
    var submitbtn 	 =  $('#contact-submit-btn');
    submitbtn.val('Sending...');
    $('#angelContactForm :input').prop('disabled', true);
    $.ajax({
      url: submiturl,
      type: 'POST',
      dataType: 'json',
      data : contactdata,
      success: function(response){
        $('#alert').removeClass('alert alert-success');
        $('#alert').removeClass('alert alert-danger');
        if(response.status=== 'true'){
          $('#alert').addClass('alert alert-success');
          $('#angelContactForm :input').prop('disabled', false);
          $('#angelContactForm')[0].reset();
          submitbtn.val('Send');
        }else{
          $('#alert').addClass('alert alert-danger');
          $('#angelContactForm :input').prop('disabled', false);
          submitbtn.val('Send');
        }
        $('#alert').html(response.message).slideDown();
        window.setTimeout(function() {
          $('#alert').alert('close'); }, 3000);
        }
      });
      e.preventDefault();
    });

    // =========================== Appoinment Form =========================
  $('#appoinmentModalForm').submit(function(e){
    var contactdata  =  $(this).serializeArray();
    var submiturl    =  $(this).attr('action');
    var submitbtn 	 =  $('#appointment-submit-btn');
    submitbtn.val('Sending...');
    $('#appoinmentModalForm :input').prop('disabled', true);
    $.ajax({
      url: submiturl,
      type: 'POST',
      dataType: 'json',
      data : contactdata,
      success: function(response){
        $('#appointment-alert').removeClass('alert alert-success');
        $('#appointment-alert').removeClass('alert alert-danger');
        if(response.status=== 'true'){
          $('#appointment-alert').addClass('alert alert-success');
          $('#appoinmentModalForm :input').prop('disabled', false);
          $('#appoinmentModalForm')[0].reset();
          submitbtn.val('Send');
        }else{
          $('#appointment-alert').addClass('alert alert-danger');
          $('#appoinmentModalForm :input').prop('disabled', false);
          submitbtn.val('Send');
        }
        $('#appointment-alert').html(response.message).slideDown();
        window.setTimeout(function() {
          $('#appointment-alert').alert('close');
        }, 3000);
      }
    });
    e.preventDefault();
  });
