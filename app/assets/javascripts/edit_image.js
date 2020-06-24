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
});



