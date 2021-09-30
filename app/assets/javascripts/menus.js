document.addEventListener('turbolinks:load', function() {  
  $('.menu_cooked').click(function() {
    let tr = $(this).parents('tr');
    let menu_id = tr.attr('id');
    let recipe_id = tr.find('.recipe_id').attr('id');
    let cooked_at = tr.find('.schedule').text();
    
    $.ajax({
      url: '/menus/change_cooked',
      type: 'POST',
      data: {
        'menu_id':menu_id,
        'recipe_id':recipe_id,
        'cooked_at':cooked_at
      }
    });
  });
});