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
});