//UI scripts

$(document).ready(function(){

  /* hide content on page load */
  $("#emails-content").hide();
  $("#overrides-content").hide();
  
  /* reset buttons on page load */
  $("#export-emails").show();
  $("#reset-emails").hide();
  $("#export-overrides").show();
  $("#reset-overrides").hide();

  /* reset input fields on page load */
  $("#input").prop('disabled', false);

  /* toggle content */
  $("#emails-link").click(function(){
    $("#overrides-content").hide();
    $("#emails-content").slideToggle("slow");
  });
  
  $("#overrides-link").click(function(){
    $("#emails-content").hide();
    $("#overrides-content").slideToggle("slow");
  });

  /* reset btn triggers page reload to refresh UI */
  $("#reset-emails").click(function() {
    location.reload();
  });

  $("#reset-overrides").click(function() {
    location.reload();
  });

});

/* swap submit and reset  btns when exporting emails */
function swapBtnsEmail() {
  $("#export-emails").hide();
  $("#reset-emails").show();
}

/* swap submit and reset btns when exporting overrides */
function swapBtnsOverrides() {
  $("#overrides-emails").hide();
  $("#reset-overrides").show();
}

/* disable input field */
function disableInput() {
  $("#input").prop('disabled', true);
}