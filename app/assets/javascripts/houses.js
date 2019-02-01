// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
(function() {
  var element = document.getElementById("house_photo");
  if (element != undefined) {
    element.onchange = function() {
      if (this.file[0].size > 5 * 1024) {
        // Files larger than 5 MB not allowed
        alert("Image too large! Please keep it under 5 MB");
        this.value = "";
      }
    };
  }
})();
