function nextStep(e,step){
  e.preventDefault();
      $('#step-'+step).fadeOut(400,function(){
        $('#step-'+(step+1)).fadeIn();
        $('#project_new').text("Step "+(step+1));
      });
}
$(function(){
  $('#nextstep-1').on('click',function(e){
    nextStep(e,1);
  });
  $('.backButton').on('click',function(e){
    e.preventDefault();
    $('#step-2').fadeOut(400,function(){
        $('#step-1').fadeIn();
        $('#project_new').text("Step 1");
      });
  });
})
