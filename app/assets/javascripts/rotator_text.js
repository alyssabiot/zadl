$(document).ready(function() {
 //Typedjs
  $(function(){
    if ($(".rotate").length) {
      $(".rotate").typed({
        strings: rotator_text,
        // showcursor
        showCursor: true,
        // backspacing speed
        backSpeed: 50,
        typeSpeed: 100,
        // loop
        loop: true,
        cursorChar: "",
      });
    }
  });
});
