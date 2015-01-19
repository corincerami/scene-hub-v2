$(function(){ $(document).foundation(); });

$(document).ready(function() {
  $('[data-show-id] [data-rsvp-button="create"]').on('submit', function(event) {
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

        // Change the form attributes
        $form.attr({
          action: action,
          'data-rsvp-button': 'delete'
        });
        $hidden = $('<input>').attr({name: '_method', type: 'hidden', value: 'delete'});
        $form.prepend($hidden);
        $button = $('[value="RSVP"]');
        $button.attr({value: "Cancel RSVP"});
      }
    });

  });

  $('[data-show-id] [data-rsvp-button="delete"]').on('submit', function(event) {
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
      $form.attr({
        action: action,
        method: 'post',
        'data-rsvp-button': 'create'
      });
      $button = $('[value]');
      $button.attr({value: "RSVP"});
      $hidden = $('[name="_method"]')
      $hidden.remove()
      }
    });
  });
});
