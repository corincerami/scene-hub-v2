$("#zip-code-button").on('click', function(toggleForm){
  $("#zip-code-form").toggle();
  toggleForm.preventDefault();
});

$("#comment-button").on('click', function(toggleForm){
  $("#comment-form").toggle();
  toggleForm.preventDefault();
});
