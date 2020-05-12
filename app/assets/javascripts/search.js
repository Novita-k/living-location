$(function() {
  let search_list = $(".contents.row");
  function appendPost(post) {
    if (post.user_sign_in && post.user_sign_in.id == post.user_id) {
      var post_user = `<li>
                         <a data-method="get" href="/posts/${post.id}/edit">編集</a>
                       </li>
                       <li>
                         <a rel="nofollow" data-method="delete" href="/posts/${post.id}">削除</a>
                       </li>`
    } else {
      var post_user = ""
    }

    let html = `<div class="content_post">
                  <a data-lightbox="${post.image}" href="${post.image}">
                    <img class="post-image" src="${post.image}">
                  </a>
                  <span class="title">
                    ${post.title}
                  </span>
                  <div class="more">
                    <span>
                      <img src="/assets/icons8-15-8ccce554d5133be2492b951a12b9b6b16cf7eb55086759906217cd87b44c3a19.png">
                    </span>
                    <ul class="more_list">
                      <li>
                        <a data-method="get" href="/posts/${post.id}">詳細</a>
                      </li>
                      ${post_user}
                    </ul>
                  </div>
                  <span class="name">
                    <a href="/users/${post.user_id}">
                      <span>投稿者</span>
                      ${post.nickname}
                    </a>
                    <a class="address" href="#">
                      ${post.address}
                    </a>
                  </span>
                </div>
                <div class="text-area">
                  <div class="text-space">
                    ${post.text}
                  </div>
                </div>`
    search_list.append(html);
  }
  function appendErrMsgToHTML(msg) {
    let html = `<div class="error_msg">${msg}</div>`
    search_list.append(html);
  }
  $(".search-input").on("keyup", function() {
    let input = $(".search-input").val();
    let url = $(this).attr("action");
    $.ajax({
      type: 'GET',
      url: url,
      data: {keyword: input},
      dataType: 'json'
    })
    .done(function(posts) {
      search_list.empty();
      if (posts.length !== 0) {
        posts.forEach(function(post){
          appendPost(post);
        });
      }
      else{
        appendErrMsgToHTML("一致する投稿がありません");
      }
    })
    .fail(function() {
      alert('error');
    });
  });
});