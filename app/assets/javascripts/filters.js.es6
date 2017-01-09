$(document).ready(function(){
  $('#all-read-button').on('click', function(){
    $('.link').each(function(index, link){
      $(link).show()
      if (link.innerText.includes('true')){
        $(link).show()
      } else {
        $(link).hide()
      }
    })
  })

  $('#all-unread-button').on('click', function(){
    $('.link').each(function(index, link){
      $(link).show()
      if (link.innerText.includes('false')){
        $(link).show()
      } else {
        $(link).hide()
      }
    })
  })

  $('#search-box').on('keyup', function(){
  var currentSearch = $(this).val().toUpperCase();

  $('.link').each(function(index, link) {
    if (link.children[1].innerText.toUpperCase().indexOf(currentSearch) !== -1) {
      $(link).show();
    } else {
      $(link).hide();
    }
  })
})
})
