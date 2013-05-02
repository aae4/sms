# Override Rails handling of confirmation

$.rails.allowAction = (element) ->
  title = element.data('confirm-title')  
  if !element.data('confirm-title') || title == "" 
    title = "Подтвердите действие"

  message = element.data('confirm')
  type = element.data('confirm-type')
  id = element.data('id')
  # If there's no message, there's no data-confirm attribute, 
  # which means there's nothing to confirm
  return true unless message
  # Clone the clicked element (probably a delete link) so we can use it in the dialog box.
  $link = element.clone()
    # We don't necessarily want the same styling as the original link/button.
    .removeAttr('class')
    # We don't want to pop up another confirmation (recursion)
    .removeAttr('data-confirm')
    # We want a button
    .addClass('btn').addClass('btn-primary')
    # We want it to confirmy
    .html("Да")

  # Create the modal box with the message
    modal_html = """
      <div class="modal fade" id="errorConfirm" tabindex="-1" role="dialog">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <h3 id="errorConfirmLabel"><i class="icon-question-sign"></i> #{title}</h3>
        </div>
        <div class="modal-body">
          <p class="text-center">#{message}</p>
        </div>
        <div class="modal-footer">
          <a data-dismiss="modal" class="btn">Нет</a>
        </div>
      </div>
      """

  $modal_html = $(modal_html)
  # Add the new button to the modal box
  $modal_html.find('.modal-footer').append($link)
  # Pop it up
  $modal_html.modal()
  # Prevent the original link from working
  return false