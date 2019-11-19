document.addEventListener('turbolinks:load', function() {
  $('.list_bought').each(function(index, element) {
    let tr = $(element).parents('tr');
    let checked =  $(element).prop('checked');
    changeBgColor(tr, checked);
  });
  
  $('.list_bought').click(function() {
    let tr = $(this).parents('tr');
    let checked =  $(this).prop('checked') 
    $.ajax({
      url: '/shopping_lists/' + $(this).parents('tr').attr('id'),
      type: 'PATCH',
      success: function () {
        changeBgColor(tr, checked);
      }
    });
  });

  function changeBgColor(tr, checked){
    if (checked){
      tr.css('background-color','gray');
    }else{
      tr.css('background-color','white');
    }
  }
});