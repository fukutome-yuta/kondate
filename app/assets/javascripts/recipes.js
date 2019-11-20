document.addEventListener('turbolinks:load', function() {  
  $('#addRow').click(function(){
    var html = '<tr class="field"><td><label for="user_name">Name</label></td><td><input type="text" name="user[name]" id="user_name"></td><input value="ID_001" type="hidden" name="user[menu_id]" id="user_menu_id"><td><label for="user_age">Age</label></td><td><input type="number" name="user[age]" id="user_age"></td><td><button class="remove">-</button></td></tr>';
    $('tbody').append(html);
  });

  $(document).on('click', '.remove', function() {
      var result = window.confirm('行を削除してよろしいですか？');
      if (result){
        $(this).parents('tr').remove();
      }
  });
});