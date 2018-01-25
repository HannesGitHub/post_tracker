$(document).on('click', '#btn-history-clicked', function(){
    var tracking_id = $(this).attr('tracking_id');
    $('#ajax-popup-modal').modal('show');
    $.ajax({
        type: "GET",
        url: "/users/trackings/" + tracking_id + "/get_statuses"
    }).done(function (response) {
        $('#ajax-modal-replacement-div').html(response);
    }).fail(function (msg) {
        alert("Ajax failed with message: " + msg.responseText)
    })
});