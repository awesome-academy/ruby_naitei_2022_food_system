$(function(){
  $(document).on('submit','.add-to-cart',function(event){
    event.preventDefault();
    let urlRequest = $(this).attr('action');
    let id = $(this).data('id');
    let quantity = $("#product_quantity_" + id).val();

    $.ajax({
      url: urlRequest,
      method: 'post',
      data:{
        id: id,
        quantity: quantity
      },
      success: function(data){
        $('#submit-add-to-cart').removeAttr('disabled');
        if(data.status === 200){
          let count = data.cart_items_count;
          $('#cart_items_count').text(count);
          toastr.success(data.message);
        }
        else{
          toastr.error(data.message);
        }
      }
    });
  });
});
