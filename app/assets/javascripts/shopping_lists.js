
//turbolinkが適用されていた場合はwindow.onloadではなくこれでページ読み込み時に処理が実行される
document.addEventListener('turbolinks:load', function() {
  $('input[type=checkbox]').click(function() {
    let name = $(this).attr('name');
    let tr = $(this).parents('tr');
    let td = tr.children('td');

    $.ajax({
      url: '/shopping_lists/' + $(this).parents('tr').attr('id'),
      type: 'PUT',
      success: function (data) {sortTable(td);}
    });

    function sortTable(td){
      $('tbody').append('<tr><td>' + td[0].innerText + '</tr></td>');
      td.remove();
    }
  });
});