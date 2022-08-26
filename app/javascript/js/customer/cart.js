$(function () {
  $(document).on("submit", ".add-to-cart", function (event) {
    event.preventDefault();
    let urlRequest = $(this).attr("action");
    let id = $(this).data("id");
    let quantity = $("#product_quantity_" + id).val();

    $.ajax({
      url: urlRequest,
      method: "post",
      data: {
        id: id,
        quantity: quantity,
      },
      success: function (data) {
        $("#submit-add-to-cart_" + id).removeAttr("disabled");
        if (data.status === 200) {
          let count = data.cart_items_count;
          $("#cart_items_count").text(count);
          toastr.success(data.message);
        } else {
          toastr.error(data.message);
        }
      },
    });
  });

  $(document).on("click", "#cart-item-destroy", function () {
    let urlRequest = $(this).data("url");
    let id = $(this).data("id");
    $.ajax({
      url: urlRequest,
      method: "delete",
      data: {
        id: id,
      },
      success: function (data) {
        if (data.status === 200) {
          $("#cart_items_count").text(data.cart_items_count);
          $("#cart-total").text(data.total);
          toastr.success(data.message);
        } else {
          toastr.error(data.message);
        }
      },
    });
  });

  $(document).on("click", ".change-quantity", function () {
    let urlRequest = $(this).data("url");
    let id = $(this).data("id");
    let quantity = $("#item-quantity_" + id).val();

    $.ajax({
      url: urlRequest,
      method: "patch",
      data: {
        id: id,
        quantity: quantity,
      },
      success: function (data) {
        if (data.status === 200) {
          $("#cart_items_count").text(data.cart_items_count);
          $("#cart-total").text(data.total);
          $("#item-sub-total_" + id).text(data.sub_total);
        } else {
          toastr.error(data.message);
        }
      },
    });
  });
});
