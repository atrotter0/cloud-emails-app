//UI scripts

//after submit, hide export button & show reset button
function disableBtn() {
  document.getElementById("export").disabled = true;
  document.getElementById("reset").disabled = false;
}

//disable input field on submit
function disableInput() {
  document.getElementById("input").disabled = true;
}

//refresh page to reset UI
function reloadPage() {
  location.reload();
}

//when page loads, reset UI
window.onload = function() {
  document.getElementById("export").disabled = false;
  document.getElementById("input").disabled = false;
  document.getElementById("reset").disabled = true;
}