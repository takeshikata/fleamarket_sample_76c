//remind
// $(function(){
//   const buildFileField = (num)=> {
//     if (num < 10) {
//     const html = `<div data-index="${num}" class="js-file_group">
//                     <input class="js-file" type="file"
//                     name="product[images_attributes][${num}][image]"
//                     id="images_attributes_${num}_src"><br>
//                     <div class="js-remove">削除</div>
//                   </div>`;
//     return html;} else {
//       return false;
//     }
//   }
//   const buildImg = (index, url)=> {
//     const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
//     return html;
//   }

//   let fileIndex = [1,2,3,4,5,6,7,8,9,10];
//   lastIndex = $('.js-file_group:last').data('index');
//   fileIndex.splice(0, lastIndex);

//   $('.hidden-destroy').hide();

//   $('#image-box').on('change', '.js-file', function(e) {
//     const targetIndex = $(this).parent().data('index');
//     const file = e.target.files[0];
//     const blobUrl = window.URL.createObjectURL(file);

//     if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
//       img.setAttribute('src', blobUrl);
//     } else {
//       $('#previews').append(buildImg(targetIndex, blobUrl));
//       $('#image-box').append(buildFileField(fileIndex[0]));
//       fileIndex.shift();
//       fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
//     }
//   });

//   $('#image-box').on('click', '.js-remove', function() {
//     const targetIndex = $(this).parent().data('index');
//     const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
//     if (hiddenCheck) hiddenCheck.prop('checked', true);

//     $(this).parent().remove();
//     $(`img[data-index="${targetIndex}"]`).remove();

//     if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
//   });
// });

$(function(){
  var index = [0,1,2,3,4,5,6,7,8,9];
  $(".flexbox").on("click", ".delete-btn", function(){
    var targetIndex = Number($(this).attr("index"));
    index.push(targetIndex);
    if($(this).parent().parent().attr("class") == "new-wrapper__main__preview-first"){
      $(".new-wrapper__main__preview .new-wrapper__main__preview__image:first").appendTo(".new-wrapper__main__preview-first");
    }
    if(index.length > 6){
      $(".new-wrapper__main__image-field").css("width",(index.length-5)*132);
    }else if(index.length == 6){
      $("#image-field-second").remove();
      $(".new-wrapper__main__preview").remove();
      $(".new-wrapper__main__preview-first").attr("class", "new-wrapper__main__preview");
      $(".new-wrapper__main__image-field").css("display","flex");
    }else if(index.length == 1){
      $("#image-field-second").css("display","flex");
      $("#image-field-second").css("width",index.length*132);
    }else{
      $("#image-field-second").css("width",index.length*132);
    }
    $("#image-wrapper").attr("for",`product_images_attributes_${targetIndex}_image`);
    $(this).parent().remove();
    $(`#product_images_attributes_${targetIndex}_image`).remove();
    $(".flexbox").append(`<input class="file-field" type="file" name="product[images_attributes][${targetIndex}][image]" id="product_images_attributes_${targetIndex}_image">`);

  })
  var buildImage = function(url){
    if(index.length != 0){
      $(".new-wrapper__main__preview").append(`
        <div class="new-wrapper__main__preview__image">
        <img class="new-wrapper__main__preview__image__img" src="${url}">
        <div class="delete-btn" index=${index[0]}><i class="far fa-times-circle"></i></div>
      `);
      $(".flexbox").append(`<input class="file-field" type="file" name="product[images_attributes][${index[1]}][image]" id="product_images_attributes_${index[1]}_image">`);
      $("#image-wrapper").attr("for",`product_images_attributes_${index[1]}_image`);
      index.shift();
      if(index.length > 5){
        $("#image-field-second").remove();
        $(".new-wrapper__main__image-field").css("display","flex");
        $(".new-wrapper__main__image-field").css("width",(index.length-5)*132);
      }else if(index.length == 5){
        $(".new-wrapper__main__image-field").css("display","none");
        $("#image-wrapper").append(`
          <div class="new-wrapper__main__image-field" id="image-field-second">
            <i class="fas fa-camera"></i>
            <div class="new-wrapper__main__image-field__text">
              ドラッグアンドドロップ
              <br>
              またはクリックしてファイルをアップロード
            </div>
          </div>
        `);
        $(".new-wrapper__main__preview").attr("class", "new-wrapper__main__preview-first");
        $(".new-wrapper__main__preview-first").after(`<div class="new-wrapper__main__preview"></div>`);
      }else if(index.length == 0){
        $("#image-field-second").css("display","none");
      }
      $("#image-field-second").css("width",index.length*132);
    }
  }
  $(".flexbox").on("change", function(e){
    var blob = window.URL.createObjectURL(e.target.files[0]);
    buildImage(blob);
  })
})
