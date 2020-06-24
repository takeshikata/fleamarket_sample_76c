$(function () {
  // プレビュー機能
  //'change'イベントでは$(this)で要素が取得できないため、 'click'イベントを入れた。
  //これにより$(this)で'input'を取得することができ、inputの親要素である'li'まで辿れる。

  $(document).on('click', '.image_upload', function () {
    //inputの要素はクリックされておらず、inputの親要素であるdivが押されている。
    //だからdivのクラス名をclickした時にイベントが作動。
    //div（this）から要素を辿ればinputを指定することが可能。
    //$liに追加するためのプレビュー画面のHTML。横長でないとバグる
    var preview = $('<div class="image-preview__wapper"><img class="preview"></div><div class="image-preview_btn"><div class="image-preview_btn_delete">削除</div></div>');
    //次の画像を読み込むためのinput。 
    var append_input = $(`<li class="input"><label class="upload-label"><div class="upload-label__text"><i class="fa fa-camera fa-4x"></i><div class="input-area display-none"><input class="hidden image_upload" type="file"></div></div></label></li>`)
    $ul = $('#previews')
    $li = $(this).parents('li');
    $label = $(this).parents('.upload-label');
    $inputs = $ul.find('.image_upload');
    //inputに画像を読み込んだら、"プレビューの追加"と"新しいli追加"処理が動く
    $('.image_upload').on('change', function (e) {
      //inputで選択した画像を読み込む
      var reader = new FileReader();
      // プレビューに追加させるために、inputから画像ファイルを読み込む。
      reader.readAsDataURL(e.target.files[0]);
      //画像ファイルが読み込んだら、処理が実行される。 
      reader.onload = function (e) {
        //previewをappendで追加する前に、プレビューできるようにinputで選択した画像を<img>に'src'で付与させる
        // つまり、<img>タグに画像を追加させる
        $(preview).find('.preview').attr('src', e.target.result);
      }

      //inputの画像を付与した,previewを$liに追加。
      $li.append(preview);
      // 生成したliの横幅を決める
      $('#previews li').css({
        'width': `80px`
      })

      //プレビュー完了後は、inputを非表示にさせる。これによりプレビューだけが残る。
      $label.css('display', 'none'); // inputを非表示
      $li.removeClass('input');     // inputのクラスはjQueryで数を数える時に邪魔なので除去
      $li.addClass('image-preview'); // inputのクラスからプレビュー用のクラスに変更した
      $lis = $ul.find('.image-preview'); // クラス変更が完了したところで、プレビューの数を数える。 

      // 画像が9枚以内なら文字とインプットを追加
      if ($lis.length < 10) {
        $ul.append(append_input)
        $('#previews li:last-child').css({
          'width': `80px`
          // 'width': `calc(80px * ${$lis.length})`
        })
      }

      //inputの最後の"data-image"を取得して、input nameの番号を更新させてる。
      // これをしないと、それぞれのinputの区別ができず、最後の1枚しかDBに保存されません。
      // 全部のプレビューの番号を更新することで、プレビューを削除して、新しく追加しても番号が1,2,3,4,5,6と綺麗に揃う。だから全部の番号を更新させる
      $inputs.each(function (num, input) {
        //nameの番号を更新するために、現在の番号を除去
        $(input).removeAttr('name');
        $(input).attr({
          name: "product[images_attributes][" + num + "][image]",
          id: "images_attributes_" + num + "_image"
        });
      });

    });
  });

  //削除ボタンをクリックしたとき、処理が動く。
  $(document).on('click', '.image-preview_btn_delete', function () {
    var append_input = $(`<li class="input"><label class="upload-label"><div class="upload-label__text"><i class="fa fa-camera fa-4x"></i><div class="input-area display-none"><input class="hidden image_upload" type="file"></div></div></label></li>`)
    $ul = $('#previews')
    $lis = $ul.find('.image-preview');
    $li = $(this).parents('.image-preview');

    //"li"ごと削除して、previewとinputを削除させる。
    $li.remove();
    $lis = $ul.find('.image-preview'); // クラス変更が完了したところで、プレビューの数を数える。 

    // 画像が10枚以内なら文字とインプットを追加
    if ($lis.length == 9) {
      $ul.append(append_input)
    }

    $('#previews li:last-child').css({
      'width': `80px`
      // 'width': `calc(80px * ${$lis.length})`
    })

  });

});