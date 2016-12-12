$(document).ready(function(){

 var clip = new Clipboard('#btn-copy');
 console.log(clip);
});

$(document).ready(function(){
  $('#btn-copy').on('click', function(e){
    swal("Votre lien a bien été copié, partagez-le vite !")
  });
});
