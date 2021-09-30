document.addEventListener('turbolinks:load', function() {  
  $('#conversion').click(function() {
 
    let original = Number($('#original').val());
    let register = Number($('#register').val());


    $('.mod-quantity').each(function(index, element) {
      let quantity = Number($(element).val());
      let modQautity = quantity / original * register;
      $(element).val(String(modQautity));
    });

    alert(original + '人分の材料を' + register + '人分にしました。');

  });

  $('#addRow').click(function(){
    let row = ing_table.rows.length - 1;
    let html = '<tr class="form-group row"><td class="col-sm-2"><input class="form-control" type="text" name="recipe[ingredients_attributes][' + row + '][name]" id="recipe_ingredients_attributes_' + row + '_name"></td><td class="col-sm-2"><input class="form-control" type="text" name="recipe[ingredients_attributes][' + row + '][amount]" id="recipe_ingredients_attributes_' + row + '_amount"></td><td class="col-sm-2"><input class="form-control mod-quantity" type="text" name="recipe[ingredients_attributes][' + row + '][quantity]" id="recipe_ingredients_attributes_' + row + '_quantity"></td><td class="col-sm-2"><select name="recipe[ingredients_attributes][' + row + '][unit_id]" id="recipe_ingredients_attributes_' + row + '_unit_id"><option value="0">個</option><option value="1">g</option><option value="2">ml</option><option value="3">大さじ</option><option value="4">小さじ</option><option value="5">少々</option></select></td><td class="col-sm-1"><button class="remove">-</button></td></tr>';
    $('tbody').append(html);
  });

  $(document).on('click', '.remove', function() {
    if (2 < ing_table.rows.length) {
      $(this).parents('tr').remove();
    }else{
      return false;
    }
  });
});