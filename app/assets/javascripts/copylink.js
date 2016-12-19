$(document).ready(function(){

 var clip = new Clipboard('.btn-copy-link');
 console.log(clip);
});

$(document).ready(function(){
  $('.btn-copy-link').on('click', function(e){
    var btn_id = this.id;
    console.log(btn_id);
    var event_id = btn_id.substring(4);
    console.log(event_id);
    var alert_id = "alert_"+event_id;
    console.log(alert_id);
    $('#'+alert_id).slideDown("slow").delay( 1500 ).slideUp("slow");
    // flash[:notice] = t('copy-link.notification');
    // swal("Votre lien a bien été copié, partagez-le vite !")
  });
});
