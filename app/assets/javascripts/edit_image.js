$(function () {
  if (document.location.href.match(/\/products\/\d/)) {
    var append_input = $(`<li class="input"><label class="upload-label"><div class="upload-label__text"><i class="fa fa-camera fa-4x"><div class="input-area"><input class="hidden image_upload input-edit-area" type="file"></div></div></label></li>`)
    $ul = $('#previews')
    $lis = $ul.find('.image-preview');
    $input = $ul.find('.input');

    if ($lis.length < 10) {
      $ul.append(append_input)
      $('#previews li:last-child').css({
        'width': `80px`
      })
    }
  }
  if (window.location.href.match(/\/products\/[1-9]?[0-9]\/edit/)){
    $(".product-new-form").on("submit", function(){
      console.log("submit");
      var name_count = $(".input-form-xregular").val().length;
      var introduction_count = $(".input-form-xlarge").val().length;
      var price_count = $(".input-form-middle").val().length;
      console.log(name_count);
      if ( !name_count ){
        console.log("name");
        alert("商品名を入れてください");
        // $('.xsubmit__btn').prop('disabled', false);
        return false;
      }
      else if ( !introduction_count ){
        console.log("introduction");
        alert("商品説明欄をご記入ください");
        return false;
      }
      else if ( !price_count ){
        console.log("price");
        alert("価格を入れてください");
        return false;
      }
      else if ($(`#preview-box__0`).length == 0){
        console.log("画像が0個のとき");
        alert("画像を添付してください");
        return false;
      }
    });
  }
});
