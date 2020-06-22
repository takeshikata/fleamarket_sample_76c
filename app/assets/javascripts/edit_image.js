$(function(){

  //プレビューのhtmlを定義
  function buildHTML(count) {
    var html = `<div class="preview-box" id="preview-box__${count}">
                  <div class="upper-box">
                    <img src="" alt="preview">
                  </div>
                  <div class="lower-box">
                    <div class="delete-box" id="delete_btn_${count}">
                      <span>削除</span>
                    </div>
                  </div>
                </div>`
    return html;
  }

  // 投稿編集時
  //iproducts/:id/editページへリンクした際のアクション
  if (window.location.href.match(/\/products\/[1-9]?[0-9]\/edit/)){
    console.log("edit遷移")
    //プレビューにidを追加
    $('.preview-box').each(function(index, box){
      $(box).attr('id', `preview-box__${index}`);
    })
    //削除ボタンにidを追加
    $('.delete-box').each(function(index, box){
      $(box).attr('id', `delete_btn_${index}`);
    })
    var count = $('.preview-box').length;
    //プレビューが10あるときは、投稿ボックスを消しておく
    if (count == 10) {
      $('.label-content').hide();
    }
  }

  // プレビューの追加
  $(document).on('change', '.hidden-field', function() {
    console.log("preview追加")

    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    console.log("id=");
    console.log(id);
    //labelボックスのidとforを更新
    $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
    //選択したfileのオブジェクトを取得
    var file = this.files[0];
    var reader = new FileReader();
    console.log(file);
    //readAsDataURLで指定したFileオブジェクトを読み込む
    reader.readAsDataURL(file);
    //読み込み時に発火するイベント
    reader.onload = function() {
      var image = this.result;
      //プレビューが元々なかった場合はhtmlを追加
      if ($(`#preview-box__${id}`).length == 0) {
        console.log("プレビューが空のとき");
        console.log("id=");
        console.log(id);
        var count = $('.preview-box').length;
        var html = buildHTML(id);
        //ラベルの直前のプレビュー群にプレビューを追加
        var prevContent = $('.label-content').prev();
        $(prevContent).append(html);
      }
      //イメージを追加
      $(`#preview-box__${id} img`).attr('src', `${image}`);
      var count = $('.preview-box').length;
      //プレビューが10個あったらラベルを隠す
      if (count == 10) {
        console.log("プレビューが10つのとき");
        $('.label-content').hide();
      }

      //プレビュー削除したフィールドにdestroy用のチェックボックスがあった場合、チェックを外す
      if ($(`#product_images_attributes_${id}__destroy`)){
        $(`#product_images_attributes_${id}__destroy`).prop('checked',false);
      }

      //ラベルのidとforの値を変更
      if(count <= 10){
        console.log("プレビューが10つ以下とき");
        console.log("count=");
        console.log(count);
        $('.label-box').attr({id: `label-box--${count}`,for: `product_images_attributes_${count}_image`});
      }
    }
  });

  // 画像の削除
  $(document).on('click', '.delete-box', function() {
    var count = $('.preview-box').length;
    console.log("count=");
    console.log(count);

    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    console.log("id=");
    console.log(id);
    $(`#preview-box__${id}`).remove();

    //新規登録時と編集時の場合分け

    //新規投稿時
    //削除用チェックボックスの有無で判定
    if ($(`#product_images_attributes_${id}__destroy`).length == 0) {
      console.log("hidden-checkboxが0のとき");
      console.log("id=");
      console.log(id);
      //フォームの中身を削除
      $(`#product_images_attributes_${id}_image`).val("");
      var count = $('.preview-box').length;
      //5個めが消されたらラベルを表示
      if (count == 10) {
        console.log("画像が10つのとき");
        console.log("id=");
        console.log(id);
        $('.label-content').show();
      }
      if(id < 10){
        console.log("id < 10のとき");
        console.log("id=");
        console.log(id);
        $('.label-box').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_image`});

      }
    } else {
      console.log("hidden-checkboxが0以外のとき");
      //投稿編集時
      $(`#product_images_attributes_${id}__destroy`).prop('checked',true);
      //10個めが消されたらラベルを表示
      if (count == 10) {
        console.log("画像が10つのとき");
        $('.label-content').show();
      }

      //ラベルのidとforの値を変更
      //削除したプレビューのidによって、ラベルのidを変更する
      if(id < 10){
        console.log("id < 10のとき");
        $('.label-box').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_image`});
      }
    }
  });
});
