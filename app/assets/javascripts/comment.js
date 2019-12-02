$(function(){

  function buildHTML(comment){  
    let html = `<p class="advise" data-id="${comment.id}">
                ${comment.text}
                <br>
                <h5 class="commenter">
                (${comment.user_name}さん)
                </h5>
                </p>`
    return html;
  }

  $('#new_comment').on('submit', function(e){
    // console.log("a");
    e.preventDefault();
    let formData = new FormData(this);
    // let href = window.location.href + '/comments'
    var url4 = $(this).attr('action');
    // console.log(formData);
    // console.log(href);
    $.ajax({
      url: url4,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data)
      $(".comments").append(html)
      $('.textbox').val('');
      $('.comments').animate({scrollTop: $('.comments')[0].scrollHeight});
    })
    .fail(function(){
      alert('error');
    })
  })

  let reloadMessages = function() {
    let last_comment_id = $('.advise:last').data("id")
    let url2 = location.href;
    // console.log(url2);
    let url3 = url2 + "/api/comments";
    console.log(url3);
    $.ajax({
      url: url3,
      type: 'get',
      dataType: 'json',
      data: {id: last_comment_id}
    })
    .done(function(comments) { 
      let insertHTML ='';
      console.log('reloading');
        comments.forEach(function(comment){
        insertHTML = buildHTML(comment);
        
        $('.comments').append(insertHTML);
      });
     if (comments.length !== 0 ){
    //  $('.comments').animate({scrollTop: $('.comments')[0].scrollHeight});
     }
    })
    .fail(function() {
    });
  };

  setInterval(reloadMessages, 5000);
})