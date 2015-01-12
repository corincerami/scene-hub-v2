$(function(){ $(document).foundation(); });

$(document).ready(function() {
  $('[data-show-id]').on('submit', '[data-rsvp-button="create"]', function(event) {
    // prevents default controller action of submitting an rsvp create
    event.preventDefault();
    // saves form params to jquery var
    $form = $(event.currentTarget);
    // sends an ajax request
    $.ajax({
      type: "POST",
      url: $form.attr('action'),
      dataType: "json",
      success: function(rsvp) {
        // Create the String version of the form action
        action = '/rsvps/' + rsvp.id;

        // Create the new form
        $newForm = $('<form>').attr({
          action: action,
          method: 'delete',
          'data-rsvp-button': 'delete'
        });

        // Create the new submit input
        $rsvpButton = $('<input>').attr({type: 'submit', value: 'Cancel RSVP'});

        // Append the new submit input to the new form
        $newForm.append($rsvpButton);

        // Replace the old create form with the new remove form
        $form.replaceWith($newForm);
      }
    });

  });

  $('[data-show-id]').on('submit', '[data-rsvp-button="delete"]', function(event) {
    event.preventDefault();

    $form = $(event.currentTarget);

    $.ajax({
      type: "DELETE",
      url: $form.attr('action'),
      dataType: "json",
      success: function() {
      // Find the parent wrapper div so that we can use its data-show-id
      $show = $form.closest('[data-show-id]');

      // Create the String version of the form action
      action = '/shows/' + $show.data('show-id') + '/rsvps';

      // Create the new form for creating a RSVP
      $newForm = $('<form>').attr({
        action: action,
        method: 'post',
        'data-rsvp-button': 'create'
      });

      // Create the new submit input
      $rsvpButton = $('<input>').attr({type: 'submit', value: 'RSVP'});

      // Append the new submit input to the new form
      $newForm.append($rsvpButton);

      // Replace the old create form with the new remove form
      $form.replaceWith($newForm);
      }
    });
  });
});
