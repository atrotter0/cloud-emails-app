//scripts

//disable export button after submit
function disableBtn() {
  document.getElementById("export").disabled = true;
  document.getElementById("reset").disabled = false;
}

function disableInput() {
  document.getElementById("input").disabled = true;
}

//refresh page to enable button
function reloadPage() {
  location.reload();
}

//when page loads, enable button
window.onload = function() {
  document.getElementById("export").disabled = false;
  document.getElementById("input").disabled = false;
  document.getElementById("reset").disabled = true;
}