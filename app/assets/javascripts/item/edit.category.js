$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  window.addEventListener('DOMContentLoaded', function() {
    function appendOption(category){
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    // 子カテゴリーの表示作成
    function appendChidrenBox(insertHTML){
      var childSelectHtml = '';
      childSelectHtml = `<div class='category-wrapper-select' id= 'children_wrapper'>
                          <div class='category-wrapper-select__box'>
                            <select class='category-wrapper__category form-control' id="child_category" name="item[category_id]" style = "width: 100%; height: 24px;">
                              <option value="指定なし" data-category="指定なし">指定なし</option>
                              ${insertHTML}
                            <select>
                          </div>
                        </div>`;
      $('.category-wrapper-box').append(childSelectHtml);
    }
    // 孫カテゴリーの表示作成
    function appendGrandchidrenBox(insertHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `<div class='category-wrapper-select' id= 'grandchildren_wrapper'>
                                <div class='category-wrapper-select__box'>
                                  <select class='category-wrapper__category form-control' id="grandchild_category" name="item[category_id]" style = "width: 100%; height: 24px;">
                                    <option value="指定なし" data-category="指定なし">指定なし</option>
                                    ${insertHTML}
                                  <select>
                                </div>
                              </div>`;
      $('.category-wrapper-box').append(grandchildSelectHtml);
    }
    // 親カテゴリー選択後のイベント
    $('#parent_category').on('change', function(){
      var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
      if (parentCategory != "指定なし" ){ //親カテゴリーが初期値でないことを確認
        $.ajax({
          url: 'get_category_children',
          type: 'GET',
          data: { parent_name: parentCategory },
          dataType: 'json',
        })
        .done(function(children){
          $('#children_wrapper').remove(); //親が変更された時、子以下を削除するする
          $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
        $('#grandchildren_wrapper').remove();
      }
    });
    // 子カテゴリー選択後のイベント
    $('.wrapper.category-wrapper').on('change', '#child_category', function(){
      var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
      if (childId != "指定なし"){ //子カテゴリーが初期値でないことを確認
        $.ajax({
          url: 'get_category_grandchildren',
          type: 'GET',
          data: { child_id: childId },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0) {
            $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除するする
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        // $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      }
    });
  });
});
